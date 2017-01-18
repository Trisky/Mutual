'use strict';
var Prepaga = require('../models').Prepaga;

module.exports = {
    //list all
    index(req, res) {
        Prepaga.findAll({})
            .then(function(prepagas) {
                res.status(200).json(prepagas);
            })
            .catch(function(error) {
                res.status(500).json(error);
            });
    }
};