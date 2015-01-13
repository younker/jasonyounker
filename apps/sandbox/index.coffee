express = require 'express'

app = module.exports = express()
require('../../client/configure_handlebars.coffee') app, 'sandbox', __dirname
require('./routes') app
