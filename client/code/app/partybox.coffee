window.onYouTubePlayerReady = ->
  player = $("#partybox-player").get(0)

  player.cueVideoById("Gg290v572Zw")

$ ->
  HomeView = Backbone.View.extend
    initialize:
      @template = _.template()
    render: ->
      $(@el).html @template()
      @

  Router = Backbone.Router.extend
    initialize: ->
      # @headerView = new HeaderView
      # $("#header").html(@headerView.render().el)
    routes:
      "": "home"
    home: ->
      if !@homeView
        @homeView = new HomeView
        @homeView.render()
      $("#content").html @homeView.el

  window.App = new Router
  Backbone.history.start()
