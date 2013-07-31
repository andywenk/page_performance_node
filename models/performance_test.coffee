class PerformanceTest
  constructor: (jobdata) ->
    @jobdata = jobdata

  run: ->
    console.log 'run performance test for', @jobdata.job_name
    Phantom = require './phantom'
    phantom = new Phantom @jobdata.urls[0]
    response_time = phantom.request()
    console.log response_time

module.exports = PerformanceTest
