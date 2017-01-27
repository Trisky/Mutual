'use strict';
var gulp = require('gulp');
var pug = require('gulp-pug');
var browserSync = require('browser-sync');
var nodemon = require('gulp-nodemon'); //para browser-sync
var plumber = require('gulp-plumber'); //para cuando pinchan los pipes, siempre ponerlo despues de la lectura del archivo
var sass = require('gulp-sass');
var wiredep = require('wiredep').stream;
var fs = require('fs');
//para JS compatible en bulde.js (frontend)
var babel = require('gulp-babel');
var browserify = require('browserify');
var sourcemaps = require('gulp-sourcemaps');
var concat = require('gulp-concat');
var babelify = require('babelify');
var watchify = require('watchify');
var assign = require('lodash.assign');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var gutil = require('gulp-util');
//fin frontend
var bower = require('gulp-bower');


//config object
var config = {
    pugPath: './client/pug/*.pug',
    destPath: 'public',
    scssPath: './client/scss/*.scss',
    cssPath: 'public/css',
    bowerDir: './bower_components',
    jsSource: './client/**/*.js',
    jsDest: 'public'
};

gulp.task('pug', function() {
    return gulp.src(config.pugPath) // Utilizamos Glob para compilar todo .pug de la carpeta
        .pipe(plumber())
        .pipe(pug())
        .pipe(gulp.dest(config.destPath));
});

gulp.task('sass', function() {
    return gulp.src(config.scssPath)
        .pipe(plumber())
        .pipe(sass({
            style: 'compressed',
            loadPath: [
                config.scssPath,
                config.bowerDir + '/bootstrap-sass/assets/stylesheets',
                config.bowerDir + '/fontawesome/scss'
            ]
        }))
        .pipe(gulp.dest(config.cssPath))
        .pipe(browserSync.stream()); //para ver cambios de stilos en el browser sin refresh
});


gulp.task('watch', function() {
    gulp.watch(config.pugPath, ['pug']);
    gulp.watch(config.scssPath, ['sass']);
});

gulp.task('serve', ['watch', 'nodemon', 'pug', 'sass', 'js'], function() { // main task 
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
        script: './server/app.js',
        ignore: ['./client/**', './public/**', 'gulpfile.js']
    }).on('start', function() {
        // to avoid nodemon being started multiple times
        // thanks @matthisk
        if (!started) {
            cb();
            started = true;
        }
    });
});

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//frontend


gulp.task('js', function() {
    var watchi = watchify(browserify({ entries: './client/index.js', debug: true }));
    return watchi
        .transform('babelify', {
            presets: ['es2015'], //,
            plugins: [
                'transform-class-properties'
            ]
        })
        .bundle()
        .pipe(source('bundle.js'))
        .pipe(gulp.dest(config.jsDest));
});
gulp.task('js2', function() {
    return browserify({ entries: './client/index.js', debug: true })
        .transform('babelify', { presets: ['es2015'] })
        .bundle()
        .pipe(source('bundle.js'))
        //.pipe(buffer())
        //.pipe(uglify())
        .pipe(gulp.dest('public'));
});
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////