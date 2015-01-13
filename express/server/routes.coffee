
module.exports = (app) ->

  app.all '*', (req, res, next) ->
    console.log 'express/server/routes.coffee bottleneck'
    next()
