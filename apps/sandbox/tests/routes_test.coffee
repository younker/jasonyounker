request = require 'supertest'
conf = require('../../../express/server/config.coffee').conf
app = require('../../../express/server.coffee')

describe 'sandbox route', ->

  describe 'GET /sandbox', ->
    it 'should be ok', (done) ->
      request.agent(app)
        .get('/sandbox')
        .expect(200)
        .end (err, res) ->
          return done(err)  if err
          done()
