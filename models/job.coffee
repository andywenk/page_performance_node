class Job
  constructor: (jobdata) ->
    @jobdata = jobdata
    @parse()

  parse: ->
    @jobdata.urls = @jobdata.urls.split(/\r\n/)
    @jobdata.job_name = @jobdata.job_name.replace(/\s/g, '_')

  create: ->
    @initialize_kue()
    console.log "[Job]: creating job #{@jobdata.job_name}"
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
  
  process: =>
    @jobs.process(
      @jobdata.job_name, 
      3,
      (job, done) => 
        repeat = job.data.repeat
        console.log "[Job]: job process #{job.id}"
        next = (i) =>
          @start_performance_test(i, 
            (err) ->
              if err
                console.log "[Job]: Error: #{err}"
                return done(err)
              console.log "[Job]: Iteration: #{i}"
              job.progress(i, repeat)
              
              if i == repeat 
                done()
              else
                next(i + 1)
          )
        next(0)
    )

  start_performance_test: (i, fn) ->
    PerformanceTest = require './performance_test'
    performance_test = new PerformanceTest @jobdata
    performance_test.run(i, 
      (err) ->
        if err
          console.log "[Job]: Error: #{err}"
          return
        fn()
    )

module.exports = Job
