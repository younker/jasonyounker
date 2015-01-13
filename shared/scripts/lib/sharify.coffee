# Middleware that injects the shared data and sharify script
# 
# On the server
#   m = new Model
#   m.set 'stashKey', 'Stashed Value'
#   m.stash('StashTest')
# 
# In express, when you render
#   res.render 'some/handlebars/template', sharify: res.sharify.script()
# 
# On your client
#   m = new Model(applyStash: 'StashTest')
#   m.get('stashKey') // 'Stashed Value'
# 
module.exports = (req, res, next) ->
  res.sharify =
    # There are tricky rules about safely embedding JSON within HTML. More info at:
    #   http://stackoverflow.com/a/4180424/266795
    toString: ->
      JSON.stringify(module.exports.data)
        .replace(/</g, '\\u003c')
        .replace(/-->/g, '--\\>')

    script: ->
      "<script type='text/javascript'>window.__sharifyData=#{@.toString()};</script>"

  next()

# The shared hash of data
module.exports.data = {}

bootstrapOnClient = module.exports.bootstrapOnClient = ->
  if typeof window != 'undefined' && window.__sharifyData
    module.exports.data = window.__sharifyData

bootstrapOnClient()
