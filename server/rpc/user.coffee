models = require("../../models")

exports.actions = (req, res, ss) ->
  req.use("session")
  req.use("request.auth")

  actions =
    currentUser: ->
      if req.loggedIn()
        models.User.findOne _id: req.session.auth.userId, (err, user) ->
          if err
            res err, loggedIn: false
          else
            res err,
              loggedIn: true
              name: user?.name
      else
        res loggedIn: false
    logout: ->
      res req.logout()

  return actions
