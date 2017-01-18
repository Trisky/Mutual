'use strict';
module.exports = function(sequelize, DataTypes) {
    var Prepaga = sequelize.define('Prepaga', {
        name: DataTypes.STRING,
        precio: DataTypes.BIGINT
    }, {
        underscored: true,
        classMethods: {
            associate: function(models) {
                // associations can be defined here
            }
        }
    });
    return Prepaga;
};