require("mongoose").connect "mongodb://localhost/partybox_test"

services = require("./../services")
services.youTube =
  getUserProfile: (authToken, callback) ->
    callback null,
      youTubeId: "1234"

