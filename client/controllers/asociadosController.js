'use strict';

export function asociadosController($scope, $location, AsociadosService) {

    $scope.searchAsociado = function() {
        var asoc = new Asociado();
        AsociadosService.get(asoc);
        //.then(data => { this.showAsoc(data); });
    };

    this.showAsoc = function(asociadosFound) {
        $scope.asociadosList = asociadosFound;
    };

    function Asociado() {
        this.nombre = $scope.nombreInput;
        this.apellido = $scope.apellidoInput;
        this.cuit = $scope.cuitInput;
    }
}