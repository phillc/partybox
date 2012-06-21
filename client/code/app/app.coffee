window.PartyBox = PartyBox = Ember.Application.create()

# PartyBox.ApplicationController = Ember.Controller.create()
PartyBox.ApplicationView       = Ember.View.extend({ templateName: 'application' })

PartyBox.Router = Ember.Router.extend
  root: Ember.State.extend
    index: Ember.State.extend
      route: '/',
      redirectsTo: 'posts'
    posts: Ember.State.extend
      route: '/posts'
      connectOutlets: (router) ->
        console.log "WTF??"
        raise "WTF??"
        router.get('applicationController').connectOutlet(App.PostsView, App.Post.find())
    post: Ember.State.extend
      route: '/posts/:post_id'

PartyBox.initialize()

window.onYouTubePlayerReady = ->
  player = $("#partybox-player").get(0)

  player.cueVideoById("Gg290v572Zw")

