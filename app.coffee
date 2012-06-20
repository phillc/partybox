http = require("http")
ss = require("socketstream")

ss.client.define "main",
  view: "app.html"
  css: [ "libs", "app.styl" ]
  code: [ "libs", "app" ]
  tmpl: "*"

ss.http.route "/", (req, res) ->
  res.serveClient "main"

ss.ws.transport.use require("ss-sockjs")
ss.client.formatters.add require("ss-coffee")
ss.client.formatters.add require("ss-jade")
ss.client.formatters.add require("ss-stylus")
ss.client.templateEngine.use require("ss-hogan")
ss.client.packAssets() if ss.env is "production"

server = http.Server(ss.http.middleware)
server.listen 4000
ss.start server
