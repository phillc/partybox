window.Foo = Foo = Ember.Application.create()

Foo.theFoo = Ember.View.extend templateName: 'the-foo'

window.onYouTubePlayerReady = ->
  player = $("#partybox-player").get(0)

  player.cueVideoById("Gg290v572Zw")

