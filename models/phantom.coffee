# models/phantom.coffee
#
# interface to PhantomJS

class Phantom
  constructor: (url) ->
    @url = @sanitize(url)
    @response_time = 0

  sanitize: (url) ->
    unless url.match(/^https?/)
      return "http://#{url}"
    url

  request: (fn) ->
    portscanner = require 'portscanner'
    phantom = require 'phantom'

    portscanner.findAPortNotInUse(40000, 60000, 'localhost', 
      (err, freeport) =>
        phantom.create({port: freeport},
          (ph) =>
            ph.createPage (page) =>
              start = Date.now()

              page.open @url, (status) =>
                if status != 'success'
                  console.log "[Phantom]: failed to load the address #{@url}"
                else
                  @response_time = Date.now() - start
                ph.exit()
                fn()
        )
      , null, null
    )

module.exports = Phantom
