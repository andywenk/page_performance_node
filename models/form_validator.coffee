jade = require 'jade'

class FormValidator
  constructor: (form_name) ->
    @form = form_name

  validate: (req) ->
    @req = req
    if @form == "create-job"
      @create_job()

  create_job: ->
    @req.sanitize('wait').toInt()
    @req.sanitize('repeat').toInt() 
    @req.check('job_name', 'is required').notEmpty()
    @req.check('wait', 'must be a number').isInt()
    @req.check('repeat', 'must be a number').isInt()
    @req.check('urls', 'is required').notEmpty()
    @req.validationErrors(true)
  
  error_message: (errors) ->
    out = '<h4>There are some errors:</h4><br>'
    for err of errors
      out += "<i>#{errors[err].param}</i>"
      out += '&nbsp;...&nbsp;'
      out += errors[err].msg
      out += '<br>'
    out

module.exports = FormValidator
