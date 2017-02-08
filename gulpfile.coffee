gulp = require 'gulp'
coffee = require 'gulp-coffee'
pug = require 'gulp-pug'
sass = require 'gulp-sass'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
cleanCSS = require 'gulp-clean-css'
del = require 'del'
runSequence = require 'run-sequence'

gulp.task 'clean', () ->
  del './gen/**/*'

gulp.task 'coffee', () ->
  gulp.src './src/*.coffee'
      .pipe coffee()
      .pipe gulp.dest './gen/'

gulp.task 'pug', () ->
  gulp.src './src/*.pug'
    .pipe pug
      pretty: true
    .pipe gulp.dest './gen/'

gulp.task 'sass', () ->
  gulp.src './src/*.scss'
    .pipe sass()
    .pipe gulp.dest './gen/'

gulp.task 'js', () ->
  gulp.src ['./gen/*.js']
    .pipe concat 'background.js'
    .pipe uglify()
    .pipe gulp.dest './bin/Banmeshi/'

gulp.task 'css', () ->
  gulp.src ['./gen/*.css']
    .pipe concat 'banmeshi.css'
    .pipe cleanCSS()
    .pipe gulp.dest './bin/'

gulp.task 'compile', () ->
  runSequence('clean', 'coffee', 'sass', 'pug', 'js', 'css')

gulp.task 'default', () ->
  runSequence('compile')

gulp.task 'watch', () ->
  coffeePath = './src/*.coffee'
  pugPath = './src/*.pug'
  sassPath = './src/*.scss'
  gulp.watch [coffeePath, pugPath, sassPath], ['compile']
