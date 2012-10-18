services = require("./services")
mongoose = require("mongoose")
mongoose.connect "mongodb://localhost/partybox"
Schema = mongoose.Schema

UserSchema = new Schema
  youTubeId: String
  googleId: String
  name: String
  givenName: String
  familyName: String
  link: String
  picture: String
  gender: String
  locale: String

UserSchema.statics.findOrCreateForLogin = (metadata, authToken, callback) ->
  User.findOne {googleId: metadata.id}, (err, user) ->
    if err || user
      callback(err, user)
    else
      user = new User
      user.googleId = metadata.id
      user.name = metadata.name
      user.givenName = metadata.given_name
      user.familyName = metadata.family_name
      user.link = metadata.link
      user.picture = metadata.picture
      user.gender = metadata.gender
      user.locale = metadata.locale

      services.youTube.getUserProfile authToken, (err, profile) ->
        if err
          callback err
        else
          console.log "profile:", profile
          user.youTubeId = profile.entry.yt$userId.$t
          console.log("saving user", user)
          user.save callback

User = mongoose.model("User", UserSchema)

exports.User = User
