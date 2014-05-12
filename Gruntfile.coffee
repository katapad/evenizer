module.exports = (grunt)->
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.initConfig
    coffee:
      build:
        options:
          bare:true
        files: [
          {
            expand: true
            cwd: 'lib/'
            src: ['**/*.coffee']
            dest: 'lib/'
            ext: '.js'
          }
        ]


  grunt.registerTask "build", ['coffee']