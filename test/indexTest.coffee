server = require('../app/index').server
should = require 'should'

beforeEach (done)->
  server.inject @path, (res)=>
    console.log "REQUEST"
    @response = res
    done()

describe '/', ->
  before ->
    @path = '/'

  it 'returns a 200', ->
    @response.statusCode.should.eql(200)

  it 'returns 10 items', ->
    data = JSON.parse @response.payload
    data.count.should.eql(10)
    data.posts.length.should.eql(10)

describe '/?count=50', ->
  before ->
    @path = '/?count=50'

  it 'returns a 200', ->
    @response.statusCode.should.eql(200)

  it 'returns 50 items', ->
    data = JSON.parse @response.payload
    data.count.should.eql(50)
    data.posts.length.should.eql(50)

describe '/foo', ->
  before ->
    @path = '/foo'

  it 'returns a 404', ->
    @response.statusCode.should.eql(404)