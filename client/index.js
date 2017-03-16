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

//services
import {
    apiService,
    AsociadosService
} from './services';

angular.module('App', ['ngRoute'])
    .config(routes)
    .service('ApiService', ['$http', apiService])
    .service('AsociadosService', ['$http', AsociadosService])
    .controller('indexController', ['$scope', '$location', indexController])
    .controller('asociadosController', ['$scope', '$location', 'AsociadosService', asociadosController])
    .controller('adminController', ['$scope', '$location', adminController]);