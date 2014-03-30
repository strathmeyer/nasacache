module.exports = (grunt)->
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.registerTask 'default', 'mochaTest'

  grunt.initConfig
    watch:
      test:
        files: [
          'app/**/*.coffee'
          'app/**/*.js'
          'test/**/*.coffee'
          'test/**/*.js'
        ]
        tasks: ['mochaTest']
    mochaTest:
      default:
        options:
          reporter: 'spec'
          require: 'coffee-script/register'
        src: ['test/**/i*.coffee']