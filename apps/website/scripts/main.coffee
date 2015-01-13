$ = require 'jquery'
Backbone = require 'backbone'
Backbone.Wreqr = require 'backbone.wreqr'
Backbone.ChildViewContainer = require 'backbone.babysitter'
Marionette = require 'backbone.marionette'
Routes = require './routes.coffee'
Router = require './router.coffee'

module.exports = ->
  Backbone.$ = $
  Marionette.$ = $

  window.app = new Marionette.Application
  options = {}

  app.on 'initialize:after', (options) ->
    options.router = new Router options
    new Routes controller: options.router
    Backbone.history.start(pushState: true) if Backbone.history

  app.start options
