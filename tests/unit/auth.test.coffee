
expect = require('chai').expect
request = require('supertest')
#server = require('../configs/testserver.coffee')
#db = require('../configs/testserver.coffee').db

restify = require('restify')
morgan = require('morgan')
_ = require('lodash')
#database = require("./config/database")
if process.env.GRAPHENEDB_URL?
  url = require('url').parse(process.env.GRAPHENEDB_URL)
  db = require('seraph')(
    server: url.protocol + '//' + url.host
    user: url.auth.split(':')[0]
    pass: url.auth.split(':')[1])
else
  db = require('seraph')()

server = restify.createServer()
server.use restify.acceptParser(server.acceptable)
server.use restify.queryParser()
server.use restify.bodyParser()
server.use morgan('dev')
server.use (req, res, next) ->
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
  res.header 'Access-Control-Allow-Headers', 'Content-Type'
  next()
  return

describe '#/auth/manageUser', ->
  log = console.log

  before (done) ->
    manageUsers = require('../../auth/manageUser')(server, db)
    done()

  beforeEach ->
    # Done to prevent any server side  console logs from the routes
    # to appear on the console when running tests
    console.log = ->

  it '- should POST a user that is a person and get back a response', (done) ->
    # the userID is the facebook id that is parsed to be an int.
    user =
      name: 'Ricardo Hinds',
      userID: 1221272058,

    request(server)
    .post('/api/v1/diaspora/auth/person/register')
    .send(user)
    .end (err, res) ->
      #enable the console log
      console.log = log
      data = JSON.parse res.text
      expect(err).to.be.null
      expect(data).to.have.any.keys('message','name','userID')
      expect(data).to.not.have.keys('error')
      expect(res.status).to.not.equal(404)
      done()
