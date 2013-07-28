# GET results

exports.new = (req, res) ->
  res.render 'jobs/new', { title: 'Jobs new' }

exports.show = (req, res) ->
  res.render 'jobs/show', { title: 'Jobs show' }
