'use strict';
import 'angular-ui-router';

export function routes($routeProvider, $locationProvider) {
    $locationProvider.html5Mode({
        enabled: true,
        requireBase: false,
        rewriteLinks: true,
    });
    $routeProvider
        .when('/', {
            templateUrl: '/public/index.html',
            controller: 'indexController',
        })
        .when('/asociados/', {
            templateUrl: '/public/asociados.html',
            controller: 'asociadosController',
        });
    alert('routes');
}