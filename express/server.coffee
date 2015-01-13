express = require 'express'

conf = require('./server/config.coffee').conf
setup = require './server/setup.coffee'

app = module.exports = express()
setup app

# Start server
app.listen conf.get('server:port'), ->
  console.log ""
  console.log "Starting Express...listening on port %d", conf.get('server:port')
