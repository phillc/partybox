http = require("http")
ss = require("socketstream")
everyauth = require("everyauth")
services = require("./services")
models = require("./models")

configureDatabase = (config) ->
  require("mongoose").connect "mongodb://localhost/partybox"

configureSocketStream = (config) ->
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
  ss.session.store.use("redis", config.redis)
  ss.http.middleware.prepend ss.http.connect.bodyParser()
  ss.http.middleware.append everyauth.middleware()

configureEveryAuth = (config) ->
  everyauth.everymodule.findUserById (userId, callback) ->
    models.User.findById(userId, callback)

  everyauth.google
    .appId(config.googleAppId)
    .appSecret(config.googleAppSecret)
    .scope("https://www.googleapis.com/auth/userinfo.profile")
    .findOrCreateUser (session, accessToken, accessTokenExtra, googleUserMetadata) ->
      console.log "logged in"
      console.log "accessToken: ", accessToken
      console.log "accessTokenExtra: ", accessTokenExtra
      console.log "googleUserMetadata: ", googleUserMetadata

      promise = @Promise()

      models.User.findOrCreateForLogin googleUserMetadata, accessToken, (err, user) ->
        if err
          promise.fail([err])
        else
          promise.fulfill(user)

      return promise
    .redirectPath("/")

exports.configure = (config) ->
  configureDatabase()
  configureSocketStream(config.socketStream)
  configureEveryAuth(config.everyAuth)

exports.boot = ->
  server = http.Server(ss.http.middleware)
  server.listen 4000
  ss.start server

