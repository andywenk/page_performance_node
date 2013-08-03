Phantom = require './phantom'
    
class PerformanceTest
  constructor: (jobdata) ->
    @jobdata = jobdata
    @response_times = []

  run: ->
    console.log '[PerformanceTest]: run performance test for', @jobdata.job_name
    first_url = @jobdata.urls.shift()
    @run_one(first_url)

  run_one: (url) ->
    console.log "[PerformanceTest]: URL: #{url}"
    phantom = new Phantom url
    phantom.request( 
      =>
        response_time = phantom.response_time
        @response_times.push {url : response_time}
        console.log "[PerformanceTest]: response time for #{url}: #{response_time}"
        if @jobdata.urls.length > 0
          next_url = @jobdata.urls.shift()
          @run_one(next_url)
        else
          @log_response_times()
    )

  log_response_times: ->
    console.log "[PerformanceTest]: all response times:"
    for response_time in @response_times
      console.log "[PerformanceTest]: response time for #{Object.keys(response_time)[0]} is #{response_time.url} ms"


module.exports = PerformanceTest
