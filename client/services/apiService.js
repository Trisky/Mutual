'use strict';
export function ApiService($http) {
    this.getInfo = function(searchTerm) {
        return $http({
            method: 'GET',
            url: searchTerm
        }).then(response => {
            return response.data;
        }, function errorCallback(response) {
            console.error();
            console.log(response);
        });
    };
}