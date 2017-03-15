'use strict';

//angular related modules
import '../bower_components/angular';
import { routes } from './routes';

//controllers
import {
    indexController,
    asociadosController,
    adminController
} from './controllers';


angular.module('App', ['ngRoute'])
    .config(routes)
    .controller('indexController', ['$scope', '$location', indexController])
    .controller('asociadosController', ['$scope', '$location', asociadosController])
    .controller('adminController', ['$scope', '$location', adminController]);