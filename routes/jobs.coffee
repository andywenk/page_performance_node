# GET results

exports.new = (req, res) ->
  res.render 'jobs/new', { title: 'Jobs new', errors: null }

exports.show = (req, res) ->
  res.render 'jobs/show', { title: 'Jobs show' }

exports.create = (req, res) ->
  Validator = require '../lib/validator'
  validator = new Validator 'create-job'
  errors = validator.validate(req)
  if errors 
    res.render 'jobs/new', { errors: errors, title: 'Jobs new - with errors' }
  else
    res.redirect '/jobs/new'



