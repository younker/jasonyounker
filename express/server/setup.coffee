express = require 'express'
Backbone = require 'backbone'
bodyParser = require 'body-parser'

sharify = require '../../shared/scripts/lib/sharify.coffee'

# bootstrap with config ok for the client
sharify.data = {}

module.exports = (app) ->
  # Backbone uses AJAX for persistence. We need a Backbone.sync adapter that
  # makes HTTP requests server-side.
  # For more information, see:
  #   https://github.com/artsy/backbone-super-sync
  Backbone.sync = require "backbone-super-sync"
  Backbone.sync.editRequest = (req) -> req.set 'User-Agent': 'bot'

  app.use sharify
  app.use bodyParser.urlencoded(extended: true)
  app.use bodyParser.json()
  app.use express.static("#{__dirname}/../../public")

  # Require app modules
  require('../lib/request_logger.coffee') app

  # Must go before we mount apps and their routes
  require('./routes.coffee') app

  # Mount Apps
  app.use require "../../apps/heartbeat/index.coffee"
  app.use require "../../apps/sandbox/index.coffee"
  app.use require "../../apps/website/index.coffee"
