exports.actions = (req, res, ss) ->
  req.use("session")
  req.use("request.auth")

  actions =
    currentUser: ->
      console.log req.session
      res req.loggedIn()
    logout: ->
      res req.logout()

  return actions
