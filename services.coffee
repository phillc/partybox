https = require("https")
querystring = require("querystring")
config = require("./config")

youtubeRequest = (path, authToken, params, callback) ->
  options =
    hostname: "gdata.youtube.com"
    port: 443
    path: "/feeds/api/" + path + "?" + querystring.stringify(params)
    headers:
      "Accept": "application/json"
      "User-Agent": "PartyBox"
      # "X-GData-Key": config.youTubeDeveloperKey
      "Authorization": "OAuth #{authToken}"

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

      if payload.error
        callback payload.error, payload
      else
        callback null, payload

exports.youTube =
  getUserProfile: (authToken, callback) ->
    params =
      v: 2
      alt: "json"

    youtubeRequest "users/default", authToken, params, (err, profile) ->
      callback err, profile


