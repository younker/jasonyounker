request = require 'supertest'
conf = require('../../../express/server/config.coffee').conf
app = require('../../../express/server.coffee')

describe 'heartbeat route', ->

  describe 'GET /heartbeat', ->
    it 'should be ok', (done) ->
      request.agent(app)
        .get('/heartbeat')
        .expect(200)
        .end (err, res) ->
          return done(err)  if err
          done()
