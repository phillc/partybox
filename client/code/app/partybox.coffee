window.onYouTubePlayerReady = ->
  player = $("#partybox-player").get(0)

  player.cueVideoById("Gg290v572Zw")

$ ->
  UserModel = Backbone.Model.extend()

  HeaderView = Backbone.View.extend
    initialize: ->
      @template = _.template($("#tmpl-header").html())
      @model.bind("change", this.render)

    render: ->
      console.log @model
      $(@el).html @template(currentUser: (@model.toJSON()))
      @

  HomeView = Backbone.View.extend
    initialize: ->
      @template = _.template($("#tmpl-home").html())

    render: ->
      $(@el).html @template()
      @

  PartyNewView = Backbone.View.extend
    initialize: ->
      @template = _.template($("#tmpl-party-new").html())
    render: ->
      $(@el).html @template()
      @

  Router = Backbone.Router.extend
    initialize: ->
      @currentUser = new UserModel
      @headerView = new HeaderView(model: @currentUser)
      $("#header").html(@headerView.render().el)
    routes:
      "": "home"
      "party/new": "partyNew"
    home: ->
      if !@homeView
        @homeView = new HomeView
        @homeView.render()
      $("#content").html @homeView.el
    partyNew: ->
      if !@partyNewView
        @partyNewView = new PartyNewView
        @partyNewView.render()
      $("#content").html @partyNewView.el


  window.App = {}
  window.App.router = new Router
  Backbone.history.start()
