path = require 'path'

module.exports = (grunt) ->

  # load all grunt tasks matching the `grunt-*` pattern
  require('load-grunt-tasks') grunt

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # https://github.com/sass/node-sass
    sass:
      sandbox:
        files: [
          expand: true
          cwd: 'apps/sandbox/styles'
          src: '**/*.scss'
          dest: 'public/styles/sandbox'
          ext: '.css'
        ]
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
          "shared/styles/vendor/normalize-3.0.2.css"
          "shared/styles/vendor/foundation.min.css"
          "apps/website/styles/**/*.css"
        ]
        dest: "public/styles/website.css"

    # https://github.com/gruntjs/grunt-contrib-clean
    clean:
      options:
        force: true
      website: [
        'apps/website/styles/**/*.css'
      ]
      public: [
        'public/**/*'
      ]

    # https://github.com/jmreidy/grunt-browserify
    browserify:
      options:
        transform: ['coffeeify', 'hbsfy']
      sandbox:
        src: [
          'apps/sandbox/scripts/*.coffee'
          'apps/sandbox/templates/**/*.hbs'
          "!apps/sandbox/templates/layouts/application.hbs"
        ]
        dest: 'public/scripts/sandbox.js'
      website:
        src: [
          'shared/scripts/lib/**/*.js'
          'shared/scripts/models/**/*.js'
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
      shared_vendor:
        files: [
          expand: true
          cwd: 'shared/scripts/vendor'
          src: '**'
          dest: 'public/scripts/vendor'
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

    # Task to control all tasks associated with style assets
    grunt.registerTask 'styles', [
      'sandbox-styles'
      'website-styles'
    ]

    # General workflow:
    #   1. compile scss to css and place in /public/sandbox.
    # We do this so we can pick/choose specific css files per page in order
    # to reduce collisions.
    grunt.registerTask 'sandbox-styles', [
      'sass:sandbox'
    ]

    # The general workflow is:
    # 1. compile all scss to css in the /website directory
    # 2. take all css files in /website and concat them; place in /public
    # 3. clean out the /website directory of all css files
    grunt.registerTask 'website-styles', [
      'sass:website'
      'concat_css:website'
      'clean:website'
    ]

    grunt.registerTask 'build', [
      'styles'
      'browserify'
      'copy'
      # 'uglify'
      # 'mochaTest'
    ]
