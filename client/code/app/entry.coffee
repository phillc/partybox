window.ss = require("socketstream")
ss.server.on "disconnect", ->
  console.log "Connection down :-("

ss.server.on "reconnect", ->
  console.log "Connection back up :-)"

window.onYouTubePlayerReady = ->
  player = $("#partybox-player").get(0)

  player.cueVideoById("Gg290v572Zw")

window.App = App = {}
App.Models = {}
App.Collections = {}
App.Views = {}

$ ->
  window.App.router = new window.App.Router
  Backbone.history.start()
