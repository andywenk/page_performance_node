express = require 'express'
expressValidator = require('express-validator')
pages = require './routes/pages'
jobs = require './routes/jobs'
http = require 'http'
path = require 'path'
require './lib/validator'

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 4000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser('your secret here')
  app.use express.session()
  app.use expressValidator({})
  app.use app.router
  app.use require('less-middleware')(src: __dirname + ' /public')
  app.use express.static(path.join(__dirname, 'public'))

app.configure 'development', ->
  app.use express.errorHandler()

app.get '/', pages.index
app.get '/contact', pages.contact
app.get '/about', pages.about
app.get '/jobs/new', jobs.new
app.post '/jobs/create', jobs.create
app.get '/jobs/show/:id', jobs.show

server = http.createServer app

server.listen app.get('port'), ->
  console.log "Express server listening on port #{app.get('port')}"
