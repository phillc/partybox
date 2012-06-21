window.ss = require("socketstream")
ss.server.on "disconnect", ->
  console.log "Connection down :-("

ss.server.on "reconnect", ->
  console.log "Connection back up :-)"

require('/partybox')
