http = require("http")
ss = require("socketstream")
everyauth = require("everyauth")
models = require("./models")

ss.client.define "main",
  view: "app.jade"
  css: [ "app.styl", "auth-buttons.css" ]
  code: [ "libs", "app" ]
  tmpl: "*"

ss.http.route "/", (req, res) ->
  res.serveClient "main"

ss.client.formatters.add require("ss-coffee")
ss.client.formatters.add require("ss-jade")
ss.client.formatters.add require("ss-stylus")
ss.client.packAssets() if ss.env is "production"
ss.session.store.use("redis")

everyauth.everymodule.findUserById (userId, callback) ->
  models.User.findById(userId, callback)

everyauth.google
  .appId(process.env.PARTYBOX_APP_ID)
  .appSecret(process.env.PARTYBOX_APP_SECRET)
  .scope("https://www.googleapis.com/auth/userinfo.profile")
  .findOrCreateUser (session, accessToken, accessTokenExtra, googleUserMetadata) ->
    promise = @Promise()

    models.User.findOrCreateForLogin googleUserMetadata, (err, user) ->
      if err
        promise.fail([err])
      else
        promise.fulfill(user)

    return promise
  .redirectPath("/")

ss.http.middleware.prepend ss.http.connect.bodyParser()
ss.http.middleware.append everyauth.middleware()

server = http.Server(ss.http.middleware)
server.listen 4000
ss.start server
