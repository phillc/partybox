window.onYouTubePlayerReady = ->
  player = $("#partybox-player").get(0)

  player.cueVideoById("Gg290v572Zw")

$ ->
  UserModel = Backbone.Model.extend()

  HeaderView = Backbone.View.extend
    initialize: ->
      @template = _.template($("#tmpl-header").html())
      @loggedInTemplate = _.template($("#tmpl-header-logged_in").html())
      @signInTemplate = _.template($("#tmpl-header-sign_in").html())
      @model.bind("change", this.render)

    render: ->
      $(@el).html @template(currentUser: @model)
      $(@el)
        .find("#user-nav")
        .html((if @model.get("loggedIn") then @loggedInTemplate else @signInTemplate)(currentUser: @model))
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
      ss.rpc "user.currentUser", (err, data) ->
        currentUser = new UserModel data
        headerView = new HeaderView(model: currentUser)
        $("#header").html(headerView.render().el)
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
