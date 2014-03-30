Nipple = require "nipple"
Hapi   = require "hapi"
config = require '../config'
hi     = require 'human-interval'

exports.server = server = Hapi.createServer "localhost", 8000,
  cache: config.get('/cache')

getNasaData = (count, next) ->
  url = "http://data.nasa.gov/api/get_recent_datasets/?count=" + count
  Nipple.get url, (err, res, payload) ->
    return next err if err
    next null, JSON.parse(payload)

server.method "getNasaData", getNasaData,
  cache:
    staleIn:      hi '55 minutes'
    expiresIn:    hi '60 minutes'
    staleTimeout: hi '0.1 seconds'

server.route
  method: "GET"
  path: "/"
  handler: (request, reply) ->
    count = request.query.count or 10
    server.methods.getNasaData count, (error, result) ->
      reply error or result

exports.server = server
