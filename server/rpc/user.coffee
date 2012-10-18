models = require("../../models")
services = require("../../services")

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
            res null,
              loggedIn: true
              name: user?.name
      else
        res loggedIn: false
    logout: ->
      res null, req.logout()
    youTubeProfile: ->
      services.youTube.getUserProfile req.session?.auth?.google?.accessToken, res
    youTubePlaylists: ->
      models.User.findOne _id: req.session.auth.userId, (err, user) ->
        services.youTube.getUserPlaylists user.youTubeId, res

  return actions
