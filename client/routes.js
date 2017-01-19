'use strict';
import 'angular-route';

export function routes($routeProvider, $locationProvider) {
    $locationProvider.html5Mode({
        enabled: true,
        requireBase: false,
        rewriteLinks: true,
    });
    $routeProvider
        .when('/', {
            templateUrl: 'index.html',
            controller: 'indexController',
        })
        .when('/asociados/', {
            templateUrl: '/asociados/index.html',
            controller: 'searchController',
        });
}