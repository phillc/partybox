https = require("https")
querystring = require("querystring")
config = require("./config")

exports.youTube =
  _request: (path, headers, params, callback) ->
    options =
      hostname: "gdata.youtube.com"
      port: 443
      path: "/feeds/api/" + path + "?" + querystring.stringify(params)
      headers: headers

    console.log "Sending youtube request", options
    https.get options, (res) ->
      data = ""
      res.on "data", (chunk) -> data += chunk
      res.on "end", ->
        try
          payload = JSON.parse(data)
        catch error
          console.log "Error parsing youtube api response", error, data
          return callback error, data

        callback payload.error, payload

  getUserProfile: (authToken, callback) ->
    params =
      alt: "json"
    headers =
      "Accept": "application/json"
      "User-Agent": "PartyBox"
      # "X-GData-Key": config.youTubeDeveloperKey
      "GData-Version": 2
      "Authorization": "OAuth #{authToken}"

    @_request "users/default", headers, params, (err, payload) ->
      callback err,
        userId: payload.entry.yt$userId.$t

  getUserPlaylists: (userId, callback) ->
    params =
      alt: "jsonc"
    headers =
      "Accept": "application/json"
      "User-Agent": "PartyBox"
      "GData-Version": 2
    @_request "users/#{userId}/playlists", headers, params, (err, payload) ->
      callback err,
        for item in payload.data.items
          playlistId: item.id
          title: item.title



