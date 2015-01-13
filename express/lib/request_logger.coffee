
module.exports = (app) ->
  app.use (req, res, next) ->
    console.log ""
    console.log 'Started %s %s for %s on %s', req.method, req.url, req.headers.host, new Date()
    console.log 'Query: %s', JSON.stringify(req.query) if req.query?

    next()
