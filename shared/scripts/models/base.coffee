Backbone = require 'backbone'
sharify = require '../lib/sharify.coffee'

module.exports = class BaseModel extends Backbone.Model

  initialize: (options) ->
    @_bootstrapData()

  stash: (k) ->
    sharify.data[k] = this.attributes

  _bootstrapData: ->
    if this.has 'applyStash'
      # Remove so it does not pollute our attributes
      key = this.get 'applyStash'
      this.unset 'applyStash'
      data = sharify.data[key] if key
      this.set(data) if data
