_ = require 'underscore'
nconf = require 'nconf'

env = process.env.NODE_ENV
env ||= 'development'

getNconf = _.memoize ->
  nconf
    .env()
    .file(env, file: "express/config/environments/#{env}.json")
    .file('global', file: 'express/config/application.json')

exports.conf = getNconf()
