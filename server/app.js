'use strict';
//setup
require('babel-register');
var express = require('express'), // call express
    app = express(), // define our app using express
    bodyParser = require('body-parser'),
    path = require('path'),
    models = require('./models');

// configure app to use bodyParser() por post
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
var port = process.env.PORT || 8000; // set  port
// =============================================================================
//  REGISTER OUR ROUTES -------------------------------
var routes = require('./routes');
app.use('/api', routes); // all of our routes will be prefixed with /api

// route error catch
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.json({
        message: err.message, //comentar esto en produccion <------
        error: err //comentar esto en produccion <------
    });
});

// =============================================================================
// 6- sync db and then start the server

models.sequelize.sync()
    .then(function() {
        app.listen(port);
        console.log('Magic happens on port ' + port);
    })
    .catch(function(err) {
        console.log(err);
    });