http = require 'http'
path = require 'path'
express = require 'express'
expressValidator = require 'express-validator'
lessMiddleware = require 'less-middleware'
pages = require './controllers/pages'
jobs = require './controllers/jobs'
kue = require 'kue'
redis = require 'redis'

kue.redis.createClient = ->
  client = redis.createClient(6379, '127.0.0.1')
  client
kue.app.listen 4001

pubDir = path.join(__dirname, 'public')

app = express()

app.configure ->
  app.set 'port', process.env.PORT || 4000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser('64312eede01968d5127984e14d755909')
  app.use express.session()
  app.use expressValidator(
    errorFormatter: (param, msg, value) ->
      namespace = param.split('.')
      root = namespace.shift()
      formParam = root

      while namespace.length
        formParam += '[' + namespace.shift() + ']'

      param : formParam,
      msg   : msg,
      value : value
  )
  app.use app.router
  app.use lessMiddleware(
    src: pubDir
    paths: [path.join(pubDir, 'stylesheets', 'less')]
    compress: true
  )
  app.use express.static(pubDir)

app.configure 'development', ->
  app.use express.errorHandler()

app.get '/', pages.index
app.get '/contact', pages.contact
app.get '/about', pages.about
app.get '/jobs/new', jobs.new
app.post '/jobs/create', jobs.create
app.get '/jobs/show', jobs.show

server = http.createServer app

server.listen app.get('port'), ->
  console.log "Express server listening on port #{app.get('port')}"
