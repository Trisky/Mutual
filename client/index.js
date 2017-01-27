'use strict';


var angular = require('../bower_components/angular');
var angularRoute = require('../bower_components/angular-route');


import { routes } from './routes';
import { indexController } from './controllers/indexController';


angular.module('App', ['ngRoute'])
    .config(routes)
    .controller('indexController', ['$scope', '$location'], indexController);


//angular.bootstrap(document, ['App']);