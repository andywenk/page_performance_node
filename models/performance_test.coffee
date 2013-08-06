# models/performance_test.coffee
#
# creates performance tests with PhantomJS

Phantom = require './phantom'
    
class PerformanceTest
  constructor: (jobdata) ->
    @jobdata = jobdata
    @response_times = []
    @iterations = @jobdata.repeat
    @urls = @jobdata.urls
    @memorize_urls = []

  run: ->
    console.log '[PerformanceTest]: run performance test for', @jobdata.job_name
    if @iterations > 0 
      first_url = @urls.shift()
      @memorize_urls.push(first_url)
      @run_one(first_url)
      @iterations -= 1
    else
      @log_response_times()

  run_one: (url) ->
    console.log "[PerformanceTest]: URL: #{url}"
    phantom = new Phantom url
    phantom.request( 
      =>
        response_time = phantom.response_time
        @response_times.push {url: url, response_time : response_time}
        console.log "[PerformanceTest]: response time for #{url}: #{response_time}"
        if @urls.length > 0
          next_url = @urls.shift()
          @memorize_urls.push(next_url)
          @run_one(next_url)
        else
          @urls = @memorize_urls
          @memorize_urls = []
          @run()
    )

  log_response_times: ->
    console.log "[PerformanceTest]: results:"
    for url in @urls
      console.log "[PerformanceTest]: average response time for #{url} is #{@calculate_average_respone_time(url)} ms"

  calculate_average_respone_time: (url) ->
    total_time = 0
    for response in @response_times
      if response.url == url
        total_time += response.response_time
    total_time / @jobdata.repeat

module.exports = PerformanceTest
