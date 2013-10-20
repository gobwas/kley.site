module.exports = (grunt) ->

  _ = grunt.util._;

  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    jade:
      production:
        options:
          data: _.extend({
            _timestamp: "<%= new Date().getTime() %>"
          }, grunt.file.readJSON "./data/application.json")
        files:
          "./public/index.html": "./views/index.jade"

    stylus:
      production:
        options:
          compress: false
        files:
          "./public/stylesheets/css/styles.css": "./public/stylesheets/stylus/**/*.styl"

    cssmin:
      production:
        files:
          './public/stylesheets/css/styles.css': ['./public/stylesheets/css/**/*.css']

    watch:
      stylus:
        files: ["./public/stylesheets/stylus/**/*.styl"]
        tasks: ["build:production"]


  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-cssmin"

  grunt.registerTask "build:production", ["stylus:production", "cssmin:production", "jade:production"]

