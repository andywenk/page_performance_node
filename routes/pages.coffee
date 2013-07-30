# GET home page.


exports.index = (req, res) ->
  res.render 'pages/index', { title: 'Index' }

exports.contact = (req, res) ->
  res.render 'pages/contact', { title: 'Contact' }

exports.about = (req, res) ->
  res.render 'pages/about', { title: 'About' }

