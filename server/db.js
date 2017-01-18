'use strict';
var Sequelize = require('sequelize');
var modelsDir = [__dirname + '/models']; // aca busca los modulos
var db = new Sequelize(
    'mutual',
    'root',
    'Willkomen23!', { dialect: 'mysql' }
);


export default db;