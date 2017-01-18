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
            templateUrl: '/app/views/index.html',
            controller: 'indexController',
        })
        .when('/search/:id', {
            templateUrl: '/app/views/search-bands.html',
            controller: 'searchController',
        })
        .when('/artist/:id', {
            templateUrl: '/app/views/band-albums.html',
            controller: 'artistController'
        })
        .when('/album/:id', {
            templateUrl: '/app/views/album-detail.html',
            controller: 'albumController',
        });
}