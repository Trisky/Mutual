'use strict';
var express = require('express'); // call express
//import asociadosCtrl from './controllers/asociadosCtrl';
var asociadosCtrl = require('./controllers/asociadosCtrl');
var prepagaCtrl = require('./controllers/prepagaCtrl');
var router = express.Router();


//test page
router.get('/', function(req, res) {
    res.json({ message: 'Bienvenido a la API!' });
});

//=========Asociados===========
router.get('/asociados', asociadosCtrl.index); //get all
router.post('/asociados/create', asociadosCtrl.create); //create one

//=========Prepagas===========
router.get('/prepagas', prepagaCtrl.index); //get all


module.exports = router;