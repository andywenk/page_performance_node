class Validator
  constructor: (form_name) ->
    @form = form_name

  validate: (req) ->
    @req = req
    if @form == "create-job"
      @create_job()

  create_job: ->
    @req.assert('job-name', 'is required').notEmpty()
    @req.validationErrors()
    

module.exports = Validator
