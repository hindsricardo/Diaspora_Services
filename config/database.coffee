# module exports the db module
local_seraph = require("seraph")({
  user:'neo4j',
  pass:'neo4j'
  })

production_seraph = require("seraph")

module.exports.settings = ->
  dbconfigs:
    dev: local_seraph
    prod: production_seraph
