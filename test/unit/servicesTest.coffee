require("./testHelper")
should = require("should")
services = require("../../services")
Charlatan = require("charlatan")

describe "youTube", ->
  describe "getUserProfile", ->
    beforeEach ->
      services.youTube._request.yields null,
        entry:
          yt$userId:
            $t: "9001"

    it "gets the user id", ->
      services.youTube.getUserProfile null, (err, profile) ->
        should.not.exist(err)
        profile.userId.should.eql "9001"

  describe "getUserPlaylists", ->
    beforeEach ->
      services.youTube._request.yields null,
        apiVersion: '2.1'
        data:
          totalItems: 2,
          startIndex: 1,
          itemsPerPage: 25,
          items:
            [
              {
                id: 'PL12345',
                created: '2012-02-11T11:34:78.000Z',
                updated: '2012-03-11T12:56:90.000Z',
                author: 'party-user',
                title: 'PartyBox',
                description: '(null)',
                size: 7,
                thumbnail: {
                  sqDefault: 'http://example.com/PL12345/default.jpg',
                  hqDefault: 'http://example.com/PL12345/hqdefault.jpg'
                }
              },
              {
                id: 'PL67890',
                created: '2011-01-23T01:45:23.000Z',
                updated: '2012-02-12T23:01:45.000Z',
                author: 'party-user',
                title: 'FunTime',
                description: '',
                size: 72,
                thumbnail: {
                  sqDefault: 'http://example.com/PL67890/default.jpg',
                  hqDefault: 'http://example.com/PL67890/hqdefault.jpg'
                }
              }
            ]

    it "get the user's playlists", (done) ->
      services.youTube.getUserPlaylists null, (err, playlists) ->
        playlists.should.eql [
          {
            playlistId: "PL12345",
            title: "PartyBox"
          },
          {
            playlistId: "PL67890",
            title: "FunTime"
          }
        ]
        done()

