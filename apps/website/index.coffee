express = require 'express'
Model = require '../../shared/scripts/models/base.coffee'

app = module.exports = express()
require('../../client/configure_handlebars.coffee') app, 'website', __dirname

app.get '/', (req, res) ->
  m = new Model
  m.set 'stashKey', 'Stashed Value'
  m.stash('StashTest')

  res.render 'homepage', sharify: res.sharify.script()
