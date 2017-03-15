'use strict';
import '../bower_components/angular-route';
export function routes($routeProvider, $locationProvider) {
    $locationProvider.html5Mode({
        enabled: true,
        requireBase: false,
        rewriteLinks: true,
    });
    $routeProvider
        .when('/', {
            templateUrl: '/home.html',
            controller: 'indexController',
        })
        .when('/asociados/', {
            templateUrl: './asocList.html',
            controller: 'asociadosController',
        })
        .when('/asociados/crear', {
            templateUrl: './asocCrear.html',
            controller: 'asociadosController',
        })
        .when('/admin/', {
            templateUrl: '/admin.html',
            controller: 'adminController',

        });
};