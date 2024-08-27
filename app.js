const express = require('express');
const mysql = require('mysql2');
const multer = require('multer');
const session = require('express-session');
const app = express();

// Create MySQL connection
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'cedtech'
});

connection.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL:', err);
        return;
    }
    console.log('Connected to MySQL database');
});

app.use(express.static('public')); // Enable static files
app.set('view engine', 'ejs'); // Set up view engine
app.use(express.urlencoded({ extended: false })); // Enable form processing

// Set up multer for file uploads
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'public/images'); // Directory to save uploaded files
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + '-' + file.originalname); // Unique filenames
    }
});
const upload = multer({ storage: storage });

// Setup session
//This is the express session thing
app.use(session({
    secret: 'secretkeycedrick', //it will be used to sign cookies which prevents tampering
    resave: false, // Stops the sessiom from bein saved if not modified during the session
    saveUninitialized: false, //New ssession that are not modified will not be saved
    cookie: { secure: false }
}));

// for nvarbar, 
app.use((req, res, next) => {
    res.locals.isLoggedIn = !!req.session.userId;
    if (req.session.userId) { // if userid found 
        res.locals.user = { // then set as local variable
            id: req.session.userId,
            username: req.session.username
        };
    }
    next();
});

// Routes
app.get('/', (req, res) => {
    console.log(req.session)
    console.log(req.session.id)
    req.session.visited = true;
    const sql = 'SELECT * FROM products WHERE popular = 1 OR recommended = 1';
    connection.query(sql, (error, results) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Internal server error');
        }
        // for my recommended and popular options in my homepage
        const recommended = results.filter(product => product.recommended === 1);
        const popular = results.filter(product => product.popular === 1);
        res.render('index', { recommended, popular });
    });
});

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
// User Account Routes
app.get('/Login', (req, res) => {
    res.render('Login', { error: null });
});

app.post('/Login', (req, res) => {
    const { email, password } = req.body;
    const sql = 'SELECT * FROM useraccount WHERE email = ?';
    connection.query(sql, [email], (error, results) => {
        // if email not found or password wrong give 401 authentication erro
        if (results.length === 0 || results[0].password !== password) {
            return res.status(401).render('Login', { error: 'Invalid email or password' });
        }
        const user = results[0];
        // Set the information to the session
        req.session.userId = user.userId;
        req.session.username = user.username;
        return res.redirect('/');
    });
});

app.get('/Register', (req, res) => {
    res.render('Register', { error: null });
});

app.post('/Register', (req, res) => {
    const { username, email, contact, password } = req.body;
    const sql = 'INSERT INTO useraccount (username, email, contact, password) VALUES (?, ?, ?, ?)';
    connection.query(sql, [username, email, contact, password], (error) => {
        if (error) {
            console.error('Error registering user:', error);
            return res.render('Register', { error: 'Error registering user (Account details exist)' });
        }
        res.redirect('/Login');
    });
});

app.get('/Logout', (req, res) => {
    req.session.destroy((err) => {
        if (err) {
            console.error('Error destroying session:', err);
            return res.status(500).send('Internal server error');
        }
        res.redirect('/');
    });
});

app.get('/user/:username', (req, res) => {
    const username = req.params.username;
    const sql = 'SELECT * FROM useraccount WHERE username = ?';
    connection.query(sql, [username], (error, results) => {
        if (error) {
            console.error('Database query error:', error.message);
            return res.status(500).send('Error retrieving user by username'); // 500 internal error
        }
        if (results.length > 0) {
            res.render('user', { user: results[0] });
        } else {
            res.status(404).send('User not found'); // 404 not found http
        }
    });
});

app.get('/editUser/:username', (req, res) => {
    const username = req.params.username;
    const sql = 'SELECT * FROM useraccount WHERE username = ?';
    connection.query(sql, [username], (error, results) => {
        if (error) {
            console.error('Database query error:', error.message);
            return res.status(500).send('Error retrieving user by username'); // 500 internal error
        }
        if (results.length > 0) {
            res.render('editUser', { user: results[0] });
        } else {
            res.status(404).send('User not found'); // 404 not found http
        }
    });
});

app.post('/updateUser/:username', (req, res) => {
    const oldUsername = req.params.username;
    const { username, email, contact, password } = req.body; //updated info extracted
    let sql = 'UPDATE useraccount SET username = ?, email = ?, contact = ?';
    const params = [username, email, contact]; // array or parameters for sql quary 
    if (password) {
        sql += ', password = ?'; // adds to sql qeury
        params.push(password); // adds to parameter arry
    }
    sql += ' WHERE username = ?'; // update according to the old username
    params.push(oldUsername);
    connection.query(sql, params, (error) => {
        if (error) {
            console.error('Error updating user details:', error.message);
            return res.status(500).send('Error updating user details');
        }
        res.redirect(`/user/${username}`);
    });
});

////////////////////////////////////////////////////////////////////////////////////////////////
// Product Management Routes
app.get('/product/:id', (req, res) => {
    const productId = req.params.id;
    const sql = 'SELECT * FROM products WHERE productId = ?';
    connection.query(sql, [productId], (error, results) => {
        if (error) {
            console.error('Database query error:', error.message);
            return res.status(500).send('Error retrieving product by ID');
        }
        if (results.length > 0) {
            const product = results[0];
            const productImages = product.productImage.split(',').map(image => image.trim());
            res.render('product', { product, productImages });
        } else {
            res.status(404).send('Product not found');
        }
    });
});

app.get('/products/:category', (req, res) => {
    const category = req.params.category;
    const selectedBrand = req.query.brand || '';
    let sqlProducts = 'SELECT * FROM products WHERE productCategory = ?';
    const params = [category];
    if (selectedBrand) {
        sqlProducts += ' AND productBrand = ?';
        params.push(selectedBrand);
    }
    const sqlBrands = 'SELECT DISTINCT productBrand FROM products';
    connection.query(sqlProducts, params, (error, productResults) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Internal server error');
        }
        connection.query(sqlBrands, (error, brandResults) => {
            if (error) {
                console.error('Database query error:', error);
                return res.status(500).send('Internal server error');
            }
            const brands = brandResults.map(row => row.productBrand);
            res.render('category', { products: productResults, category: category, brands: brands, selectedBrand: selectedBrand });
        });
    });
});

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Add product page
app.get('/addProduct', (req, res) => {
    const sql = 'SELECT * FROM products';
    connection.query(sql, (error, results) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Internal server error');
        }
        res.render('addProduct', { products: results, product: null });
    });
});

app.post('/addProduct', upload.array('productImages', 10), (req, res) => {
    const { productName, productCategory, productBrand, productPrice, productQuantity, popular, recommended, description } = req.body;
    const productImages = req.files.map(file => file.filename).join(',');
    const sql = 'INSERT INTO products (productName, productCategory, productBrand, productPrice, productQuantity, popular, recommended, description, productImage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)';
    connection.query(sql, [productName, productCategory, productBrand, productPrice, productQuantity, popular, recommended, description, productImages], (error) => {
        if (error) {
            console.error('Error adding product:', error.message);
            return res.status(500).send('Error adding product');
        }
        res.redirect('/addProduct');
    });
});


app.get('/editProduct/:id', (req, res) => {
    const productId = req.params.id;
    const sql = 'SELECT * FROM products WHERE productId = ?';
    connection.query(sql, [productId], (error, results) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Internal server error');
        }
        if (results.length > 0) {
            const product = results[0];
            connection.query('SELECT * FROM products', (error, allProducts) => {
                if (error) {
                    console.error('Database query error:', error);
                    return res.status(500).send('Internal server error');
                }
                res.render('addProduct', { products: allProducts, product: product });
            });
        } else {
            res.status(404).send('Product not found');
        }
    });
});

app.post('/updateProduct/:id', upload.array('productImages', 10), (req, res) => {
    const productId = req.params.id;
    const { productName, productCategory, productBrand, productPrice, productQuantity, popular, recommended, description } = req.body;
    let productImages = req.body.existingImages ? req.body.existingImages.split(',') : [];
    if (req.body.removeImages) {
        const imagesToRemove = Array.isArray(req.body.removeImages) ? req.body.removeImages : [req.body.removeImages];
        productImages = productImages.filter(image => !imagesToRemove.includes(image));
    }
    if (req.files.length > 0) {
        const newImages = req.files.map(file => file.filename);
        productImages = productImages.concat(newImages);
    }
    const updatedImages = productImages.join(',');
    const sql = 'UPDATE products SET productName = ?, productCategory = ?, productBrand = ?, productPrice = ?, productQuantity = ?, popular = ?, recommended = ?, description = ?, productImage = ? WHERE productId = ?';
    connection.query(sql, [productName, productCategory, productBrand, productPrice, productQuantity, popular, recommended, description, updatedImages, productId], (error) => {
        if (error) {
            console.error('Error updating product:', error.message);
            return res.status(500).send('Error updating product');
        }
        res.redirect('/addProduct');
    });
});

app.post('/deleteProduct', (req, res) => {
    const { productId } = req.body;
    const sql = 'DELETE FROM products WHERE productId = ?';
    connection.query(sql, [productId], (error, results) => {
        if (error) {
            console.error('Error deleting product:', error);
            return res.status(500).send('Error deleting product');
        }
        res.redirect('/addProduct');
    });
});

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Shopping Cart Routes
app.post('/addtocart', (req, res) => {
    const { productId, quantity, price } = req.body;
    const userId = req.session.userId;
    if (!userId) {
        return res.redirect('/Login');
    }
    const checkCartSql = 'SELECT cartId FROM usercart WHERE userId = ?';
    connection.query(checkCartSql, [userId], (error, results) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Error checking cart');
        }
        let cartId;
        if (results.length === 0) {
            const createCartSql = 'INSERT INTO usercart (userId) VALUES (?)';
            connection.query(createCartSql, [userId], (error, result) => {
                if (error) {
                    console.error('Database query error:', error);
                    return res.status(500).send('Error creating cart');
                }
                cartId = result.insertId;
                addProductToCart(cartId, productId, quantity, price, res);
            });
        } else {
            cartId = results[0].cartId;
            addProductToCart(cartId, productId, quantity, price, res);
        }
    });
});

function addProductToCart(cartId, productId, quantity, price, res) {
    const sql = 'INSERT INTO usercartitems (cartId, productsId, quantity, price) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity), price = VALUES(price)';
    connection.query(sql, [cartId, productId, quantity, price], (error) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Error adding to cart');
        }
        res.redirect('/shopping-cart');
    });
}

app.get('/shopping-cart', (req, res) => {
    const userId = req.session.userId;
    if (!userId) {
        return res.redirect('/Login');
    }
    const sql = `
        SELECT usercartitems.usercartitemsId, products.productName, usercartitems.price, usercartitems.quantity, products.productImage
        FROM usercartitems
        JOIN products ON usercartitems.productsId = products.productId
        JOIN usercart ON usercartitems.cartId = usercart.cartId
        WHERE usercart.userId = ?
    `;
    connection.query(sql, [userId], (error, results) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Error retrieving cart');
        }
        res.render('shopping-cart', { cartItems: results });
    });
});

app.post('/updatequantity', (req, res) => {
    const { usercartitemsId, quantity } = req.body;
    const sql = 'UPDATE usercartitems SET quantity = ? WHERE usercartitemsId = ?';
    connection.query(sql, [quantity, usercartitemsId], (error) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Error updating quantity');
        }
        res.redirect('/shopping-cart');
    });
});

app.post('/removefromcart', (req, res) => {
    const { usercartitemsId } = req.body;
    const sql = 'DELETE FROM usercartitems WHERE usercartitemsId = ?';
    connection.query(sql, [usercartitemsId], (error) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Error removing item from cart');
        }
        res.redirect('/shopping-cart');
    });
});

// Checkout Routes
app.get('/checkout', (req, res) => {
    const userId = req.session.userId;
    if (!userId) {
        return res.redirect('/Login');
    }
    const sql = `
        SELECT usercartitems.usercartitemsId, products.productName, usercartitems.price, usercartitems.quantity, products.productImage
        FROM usercartitems
        JOIN products ON usercartitems.productsId = products.productId
        JOIN usercart ON usercartitems.cartId = usercart.cartId
        WHERE usercart.userId = ?
    `;
    connection.query(sql, [userId], (error, results) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Error retrieving cart');
        }
        res.render('checkout', { cartItems: results });
    });
});

app.post('/checkout', (req, res) => {
    const { shippingAddress, paymentMethod } = req.body;
    const userId = req.session.userId;
    if (!userId) {
        return res.redirect('/Login');
    }
    const sqlOrder = 'INSERT INTO orders (userId, shippingAddress, paymentMethod) VALUES (?, ?, ?)';
    connection.query(sqlOrder, [userId, shippingAddress, paymentMethod], (error, results) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Error processing order');
        }
        const orderId = results.insertId;
        const sqlOrderItems = `
            INSERT INTO orderitems (orderId, productId, quantity, price)
            SELECT ?, productsId, quantity, price FROM usercartitems
            JOIN usercart ON usercartitems.cartId = usercart.cartId
            WHERE usercart.userId = ?
        `;
        connection.query(sqlOrderItems, [orderId, userId], (error) => {
            if (error) {
                console.error('Database query error:', error);
                return res.status(500).send('Error processing order items');
            }
            const sqlClearCart = 'DELETE FROM usercartitems WHERE cartId IN (SELECT cartId FROM usercart WHERE userId = ?)';
            connection.query(sqlClearCart, [userId], (error) => {
                if (error) {
                    console.error('Database query error:', error);
                    return res.status(500).send('Error clearing cart');
                }
                res.render('order-confirmation', { orderId });
            });
        });
    });
});

// Wishlist Routes
app.post('/addtowishlist', (req, res) => {
    const { productId } = req.body;
    const userId = req.session.userId;
    if (!userId) {
        return res.redirect('/Login');
    }
    const sql = 'INSERT INTO wishlist (userId, productsId) VALUES (?, ?)';
    connection.query(sql, [userId, productId], (error) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Error adding to wishlist');
        }
        res.redirect('/wishlist');
    });
});

app.get('/wishlist', (req, res) => {
    const userId = req.session.userId;
    if (!userId) {
        return res.redirect('/Login');
    }
    const sql = `
        SELECT wishlist.wishlistId, products.productName, products.productBrand, products.productPrice
        FROM wishlist
        JOIN products ON wishlist.productsId = products.productId
        WHERE wishlist.userId = ?
    `;
    connection.query(sql, [userId], (error, results) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Error retrieving wishlist');
        }
        res.render('wishlist', { wishlistItems: results });
    });
});

app.post('/remove-from-wishlist', (req, res) => {
    const { wishlistId } = req.body;
    const sql = 'DELETE FROM wishlist WHERE wishlistId = ?';
    connection.query(sql, [wishlistId], (error) => {
        if (error) {
            console.error('Database query error:', error);
            return res.status(500).send('Error removing item from wishlist');
        }
        res.redirect('/wishlist');
    });
});
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Contact Us Routes
app.get('/ContactUs', (req, res) => {
    res.render('ContactUs');
});

app.post('/ContactUs', (req, res) => {
    const { name, email, subject, message } = req.body;
    const sql = 'INSERT INTO contact (name, email, subject, message) VALUES (?, ?, ?, ?)';
    connection.query(sql, [name, email, subject, message], (error) => {
        if (error) {
            console.error('Error saving contact message:', error);
            return res.status(500).send('Error saving contact message');
        }
        res.redirect('/ContactUs');
    });
});

// Start Server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
////////////////////////////////////////////////////////////////////////////////////////////////////////////////