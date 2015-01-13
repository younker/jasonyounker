expressHandlebars = require 'express-handlebars'
HandlebarsHelpers = require '../shared/scripts/lib/handlebars_helpers.coffee'

module.exports = (app, app_name, dir) ->

  handlebars = expressHandlebars.create
    extname: '.hbs'
    layoutsDir: "apps/#{app_name}/templates/layouts"
    partialsDir: "apps/#{app_name}/templates"
    defaultLayout: 'application'
    helpers: HandlebarsHelpers

  app.engine 'hbs', handlebars.engine
  app.set 'view engine', 'hbs'
  app.set 'views', "#{dir}/templates/pages"
  app.set 'layout', "#{dir}/templates/layout/application"
