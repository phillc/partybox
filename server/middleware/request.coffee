everyauth = require("everyauth")

exports.auth = ->
  (req, res, next) ->
    req.logout = ->
      delete req.session.auth
      req.session.save()
    req.loggedIn = ->
      !!(req?.session?.auth?.loggedIn)

    next()

