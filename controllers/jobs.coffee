# controllers/jobs.coffee
#
# handle requests under jobs

exports.new = (req, res) ->
  res.render 'jobs/new', 
    title: 'Jobs new', 
    errors: null, req: {}

exports.show = (req, res) ->
  res.render 'jobs/show', 
    title: 'Jobs show'

exports.create = (req, res) ->
  FormValidator = require '../models/form_validator'
  validator = new FormValidator 'create-job'

  errors = validator.validate(req)
  
  if errors 
    res.render 'jobs/new', 
      errors: validator.error_message(errors), 
      title: 'Jobs new - with errors'
      req: req.body
  else
    Job = require '../models/job'
    job = new Job req.body
    job.create()
    job.process()

    res.redirect '/jobs/show'
