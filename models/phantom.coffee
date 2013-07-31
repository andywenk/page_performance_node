class Phantom
  constructor: (url) ->
    @url = url

  request: ->
    childProcess = require('child_process')
    path = require('path')
    phantomjs = require('phantomjs')
    binPath = phantomjs.path

    childArgs = [
      path.join(__dirname, 'loadspeed.js')
      #'some other argument (passed to phantomjs script)'
    ]

    childProcess.execFile(binPath, childArgs, (err, stdout, stderr) ->
      console.log err
      console.log stdout
      console.log stderr
    )
    # #page = require('webpage').create()
    # t = Date.now()
    # response_time = 0
    
    # open(@url, (status) ->
    #   unless status == 'success'
    #     console.log('FAIL to load the address')
    #   else
    #     response_time = Date.now() - t
    #   phantom.exit()
    # )
    # response_time

module.exports = Phantom


