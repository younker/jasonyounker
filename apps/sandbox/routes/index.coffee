
module.exports = (app) ->
  @.css = ['sandbox']

  app.get '/sandbox', (req, res) ->
    res.render 'index', head_title: 'Index', css: @.css
