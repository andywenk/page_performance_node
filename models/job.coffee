class Job
  constructor: (jobdata) ->
    @jobdata = jobdata
    @parse()

  parse: ->
    @jobdata.urls = @jobdata.urls.split(/\r\n/)
    @jobdata.job_name = @jobdata.job_name.replace(/\s/g, '_')

  create: ->
    @initialize_kue()
    console.log '[kue]: creating job', @jobdata.job_name
    @jobs.create(@jobdata.job_name,
      {
        title: @jobdata.job_name,
        wait: @jobdata.wait,
        repeat: @jobdata.repeat,
        scripttags: @jobdata.scripttags,
        iframes: @jobdata.iframes,
        urls: @jobdata.urls
      }
    ).save()

  initialize_kue: ->
    kue = require('kue')
    @jobs = kue.createQueue()
  
  process: ->
    @jobs.process(@jobdata.job_name, 1, @start_performance_test())

  start_performance_test: ->
    PerformanceTest = require './performance_test'
    performance_test = new PerformanceTest @jobdata
    performance_test.run()


module.exports = Job
