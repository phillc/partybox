App.Views.Header = Backbone.View.extend
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

App.Views.Home = Backbone.View.extend
  initialize: ->
    @template = _.template($("#tmpl-home").html())
  render: ->
    $(@el).html @template()
    @

App.Views.PartyNew = Backbone.View.extend
  initialize: ->
    @template = _.template($("#tmpl-party-new").html())
  render: ->
    $(@el).html @template()
    @
