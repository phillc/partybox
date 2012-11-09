App.Router = Backbone.Router.extend
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

