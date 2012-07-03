window.PartyBox = PartyBox = Ember.Application.create()

window.onYouTubePlayerReady = ->
  player = $("#partybox-player").get(0)

  player.cueVideoById("Gg290v572Zw")

