{Robot, User, EnterMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'welcome', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      done()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    beforeEach ->
      @callback = @sinon.spy()
      @robot.listeners[0].callback = @callback

    describe 'receive EnterMessage (id: bouzuya room: hitoridokusho)', ->
      beforeEach ->
        @sender = new User 'bouzuya', room: 'hitoridokusho'
        message = null
        @robot.adapter.receive new EnterMessage(@sender, message)

      it 'calls *welcome* with specified user', ->
        assert @callback.callCount is 1
        assert @callback.firstCall.args[0].match is true
        assert.deepEqual @callback.firstCall.args[0].envelope.user, @sender

  describe 'listeners[0].callback', ->
    beforeEach ->
      @hello = @robot.listeners[0].callback

    describe 'receive EnterMessage ...', ->
      beforeEach ->
        @reply = @sinon.spy()
        @hello
          match: true
          reply: @reply

      it 'reply "welcome!"', ->
        assert @reply.callCount is 1
        assert @reply.firstCall.args[0] is 'welcome!'
