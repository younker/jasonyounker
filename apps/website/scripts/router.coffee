Model = require '../../../shared/scripts/models/base.coffee'
Marionette = require 'backbone.marionette'

module.exports = class Router extends Marionette.Controller

  index: ->
    m = new Model(applyStash: 'StashTest')

    if m.has 'stashKey'
      console.log 'sharify worked', m
    else
      console.log 'sharify busted', m
