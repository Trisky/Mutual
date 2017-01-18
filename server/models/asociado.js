'use strict';


module.exports = function(sequelize, DataTypes) {

    var Asociado = sequelize.define('Asociado', {
        name: {
            type: DataTypes.STRING,
            allowNull: false
        },
        apellido: {
            type: DataTypes.STRING,
            allowNull: false
        }
    }, {
        underscored: true,
        classMethods: {
            associate: function(models) {
                Asociado.hasMany(models.Prepaga);
            }
        }
    });
    return Asociado;
};