
  restify = require('restify')
  morgan = require('morgan')
  _ = require('lodash')
  #database = require("./config/database")
  Mocha = require 'mocha'
  mocha = new Mocha
  if process.env.GRAPHENEDB_URL?
    url = require('url').parse(process.env.GRAPHENEDB_URL)
    db = require('seraph')(
      server: url.protocol + '//' + url.host
      user: url.auth.split(':')[0]
      pass: url.auth.split(':')[1])
  else
    db = require('seraph')({
      user: "neo4j",
      pass: "Car81you"
      })

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
  server.listen process.env.PORT or 1984, ->
    console.log 'Server started @ ', process.env.PORT or 1984
    return
  manageUsers = require('./auth/manageUser')(server, db)
  #manageLists = require('./list/manageList')(server, db)
  unitTest = require('./tests/configs/programmatic-run.coffee')(mocha)
