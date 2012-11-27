require("./testHelper")
should = require("should")
services = require("./../services")

describe "youTube", ->
  describe "getUserProfile", ->
    it "figures out youtube's crazy json response", ->
      services.youTube._request.yields null,
        entry:
          yt$userId:
            $t: "9001"

      services.youTube.getUserProfile null, (err, profile) ->
        should.not.exist(err)
        profile.youTubeId.should.eql "9001"





