http = require("http")
ss = require("socketstream")
everyauth = require("everyauth")

ss.client.define "main",
  view: "app.jade"
  css: [ "app.styl" ]
  code: [ "libs", "app" ]
  tmpl: "*"

ss.http.route "/", (req, res) ->
  res.serveClient "main"

ss.ws.transport.use require("ss-sockjs")
ss.client.formatters.add require("ss-coffee")
ss.client.formatters.add require("ss-jade")
ss.client.formatters.add require("ss-stylus")
ss.client.packAssets() if ss.env is "production"

everyauth.google
  .appId(process.env.PARTYBOX_APP_ID)
  .appSecret(process.env.PARTYBOX_APP_SECRET)
  .scope("https://www.googleapis.com/auth/userinfo.profile")
  .handleAuthCallbackError (req, res) ->
    console.log("error...")
  .findOrCreateUser (session, accessToken, accessTokenExtra, googleUserMetadata) ->
    console.log("find or create...")
    console.log session
    console.log "***"
    console.log accessToken
    console.log "***"
    console.log accessTokenExtra
    console.log "***"
    console.log googleUserMetadata
    thatPromise = @promise
    thatPromise
  .redirectPath("/")

# ss.http.middleware.prepend ss.http.connect.bodyParser()
ss.http.middleware.append everyauth.middleware()

server = http.Server(ss.http.middleware)
server.listen 4000
ss.start server
