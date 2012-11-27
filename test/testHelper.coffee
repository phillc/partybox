sinon = require("sinon")
services = require("./../services")

require("mongoose").connect "mongodb://localhost/partybox_test"

beforeEach ->
  @sinon = sinon.sandbox.create();
  @sinon.stub services.youTube, "_request"

afterEach ->
  @sinon.restore()
