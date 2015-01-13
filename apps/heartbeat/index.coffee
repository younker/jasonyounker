# The express app for /heartbeat
express = require "express"

app = module.exports = express()

app.get '/heartbeat', (req, res) ->
  res.json status: 'up'
