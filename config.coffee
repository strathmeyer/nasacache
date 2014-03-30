Confidence = require 'confidence'

rtg_url = require("url").parse(process.env.REDISTOGO_URL) if process.env.REDISTOGO_URL

store = new Confidence.Store
  cache:
    $filter: 'env'
    production:
      engine: 'catbox-redis',
      host: rtg_url?.hostname
      port: rtg_url?.port
      password: rtg_url?.auth.split(":")[1]
    $default: 'catbox-memory'

criteria =
  env: process.env.ENVIRONMENT

exports.get = (key)->
  store.get key, criteria