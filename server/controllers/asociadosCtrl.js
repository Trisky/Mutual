'use strict';
var Asociado = require('../models').Asociado;

module.exports = {
    //list all Asociados
    index(req, res) {
        Asociado.findAll({})
            .then(function(asociados) {
                res.status(200).json(asociados);
            })
            .catch(function(error) {
                res.status(500).json(error);
            });
    },
    create(req, res) {
        Asociado.create(req.body)
            .then(function(newAsoc) {
                res.status(200).json(newAsoc);
            })
            .catch(function(error) {
                res.status(500).json(error);
            });
    }
};