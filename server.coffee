(->

  restify = require('restify')
  mongojs = require('mongojs')
  morgan = require('morgan')
  _ = require('lodash')
  #database = require("./config/database")
  db = require('seraph')("http://app45557491:jp4vvUS6DcOybu6H4EFi@app45557491.sb02.stations.graphenedb.com:24789")

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
  server.listen process.env.PORT or 9804, ->
    console.log 'Server started @ ', process.env.PORT or 9804
    return
  manageUsers = require('./auth/manageUser')(server, db)
  #manageLists = require('./list/manageList')(server, db)
  return
).call this
