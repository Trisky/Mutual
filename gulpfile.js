'use strict';
var gulp = require('gulp');
var pug = require('gulp-pug');
var browserSync = require('browser-sync');
var nodemon = require('gulp-nodemon'); //para browser-sync
var plumber = require('gulp-plumber'); //para cuando pinchan los pipes, siempre ponerlo despues de la lectura del archivo
var sass = require('gulp-sass');

var bower = require('gulp-bower');


//config object
var config = {
    pugPath: './client/pug/*.pug',
    destPath: 'public',
    scssPath: './client/scss/*.scss',
    cssPath: 'public/css',
    bowerDir: './bower_components'
};


gulp.task('pug', function() {
    return gulp.src(config.pugPath) // Utilizamos Glob para compilar todo .pug de la carpeta
        .pipe(plumber())
        .pipe(pug())
        .pipe(gulp.dest(config.destPath));
});
gulp.task('sass_old', function() {
    return gulp.src(config.scssPath)
        .pipe(plumber())
        .pipe(sass())
        .pipe(gulp.dest(config.cssPath))
        .pipe(browserSync.stream()); //para ver cambios de stilos en el browser sin refresh
});

gulp.task('icons', function() {
    return gulp.src(config.bowerDir + '/fontawesome/fonts/**.*')
        .pipe(gulp.dest('./public/fonts'));
});

gulp.task('sass', function() {
    return gulp.src(config.scssPath)
        .pipe(plumber())
        //.pipe(sass())
        .pipe(sass({
            style: 'compressed',
            loadPath: [

                config.bowerDir + '/bootstrap-sass-official/assets/stylesheets',
                config.bowerDir + '/fontawesome/scss',
            ]
        }))
        .pipe(gulp.dest(config.cssPath))
        .pipe(browserSync.stream()); //para ver cambios de stilos en el browser sin refresh
});



gulp.task('watch', ['pug'], function() {
    gulp.watch(config.pugPath, ['pug']);
    gulp.watch(config.scssPath, ['sass']);
});

gulp.task('serve', ['watch', 'sass', 'nodemon'], function() { // main task 
    browserSync.init(null, {
        server: {
            baseDir: [config.destPath]
        },
        browser: "google chrome",
        port: 7000,
    });
    gulp.watch(config.destPath + '/**.html').on('change', browserSync.reload);
});
gulp.task('nodemon', function(cb) {

    var started = false;

    return nodemon({
        script: './server/app.js'
    }).on('start', function() {
        // to avoid nodemon being started multiple times
        // thanks @matthisk
        if (!started) {
            cb();
            started = true;
        }
    });
});


gulp.task('bower', function() {
    return bower()
        .pipe(gulp.dest(config.bowerDir));
});