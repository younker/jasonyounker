path = require 'path'

module.exports = (grunt) ->

  # load all grunt tasks matching the `grunt-*` pattern
  require('load-grunt-tasks') grunt

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # https://github.com/sass/node-sass
    sass:
      website:
        files: [
          expand: true
          cwd: 'apps/website/styles'
          src: '**/*.scss'
          dest: 'apps/website/styles'
          ext: '.css'
        ]

    concat_css:
      website:
        src: [
          "apps/website/styles/**/*.css"
        ]
        dest: "public/styles/website.css"

    # https://github.com/gruntjs/grunt-contrib-clean
    clean:
      options:
        force: true
      website: [
        'apps/website/styles/**/*.css'
        '!apps/website/styles/vendor/*.css'
      ]
      public: [
        'public/styles/**/*.css'
        '!public/styles/vendor/*.css'
        'public/scripts/**/*.js'
        '!public/scripts/vendor/*.js'
        'public/images/**/*'
      ]

    # https://github.com/jmreidy/grunt-browserify
    browserify:
      options:
        transform: ['coffeeify', 'hbsfy']
      sandbox:
        src: [
          'shared/**/*.{js, coffee, hbs}'
          'apps/sandbox/scripts/*.coffee'
          'apps/sandbox/templates/**/*.hbs'
          "!apps/sandbox/templates/layouts/application.hbs"
        ]
        dest: 'public/scripts/sandbox.js'
      website:
        src: [
          'shared/**/*.{js, coffee, hbs}'
          'apps/website/scripts/**/*.coffee'
          'apps/website/templates/**/*.hbs'
          "!apps/website/templates/layouts/application.hbs"
        ]
        dest: 'public/scripts/website.js'

    # https://github.com/gruntjs/grunt-contrib-copy
    copy:
      sandbox:
        files: [
          expand: true
          cwd: 'apps/sandbox/images'
          src: '**'
          dest: 'public/images/sandbox'
        ]
      website:
        files: [
          expand: true
          cwd: 'apps/website/images'
          src: '**'
          dest: 'public/images/'
        ]
      shared:
        files: [
          expand: true
          cwd: 'shared/images'
          src: '**'
          dest: 'public/images'
        ]

    # https://github.com/gruntjs/grunt-contrib-uglify
    uglify:
      scripts:
        files: [
          expand: true,
          cwd: 'public/scripts'
          src: '*.js'
          dest: 'public/scripts'
        ]

    # https://github.com/pghalliday/grunt-mocha-test
    mochaTest:
      src: [
        'apps/*/tests/**/*.coffee'
      ]
      options:
        reporter: 'spec'
        clearRequireCache: true
        require: [
          'coffee-script/register'
          should = require('chai').should()
          ->
            process.env.NODE_ENV = 'test'
        ]

    # https://github.com/gruntjs/grunt-contrib-watch
    watch:
      options:
        livereload: true
        spawn: false
      sass:
        files: [
          'apps/*/styles/**/*.scss'
        ]
        tasks: [
          'styles'
        ]
      coffee:
        files: [
          'shared/**/*.coffee'
          'apps/*/index.coffee'
          'apps/*/scripts/**/*.coffee'
        ]
        tasks: [
          'browserify'
        ]
      handlebars:
        files: [
          'apps/*/templates/**/*.hbs'
        ]
        tasks: [
          'browserify',
        ]
      static:
        files: [
          'apps/*/images/**/*.*'
        ]
        tasks: [
          'copy'
        ]

    grunt.registerTask 'styles', [
      'clean:public'
      'sass'      
      'concat_css'
      'clean:website'
    ]

    grunt.registerTask 'build', [
      'styles'
      'browserify'
      'copy'
      # 'uglify'
      # 'mochaTest'
    ]
