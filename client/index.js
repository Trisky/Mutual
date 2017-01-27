'use strict';


var angular = require('angular');
var routes = require('./routes');
//var ctrls = require('./controllers');

var indexController = require('./controllers/indexController');
//var indexController = ctrls.indexController;

//import { angular } from '@angular';
// import { routes } from './routes';
// import { indexController } from './controllers/indexController';
console.log(routes);
angular.module('App', ['ngRoute'])
    .config(routes)
    .controller('indexController', ['$scope', '$location'], indexController);