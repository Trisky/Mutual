'use strict';

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
            templateUrl: '/asociados.html',
            controller: 'asociadosController',
        });
}