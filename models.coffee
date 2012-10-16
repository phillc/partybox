mongoose = require('mongoose')
mongoose.connect 'mongodb://localhost/partybox'
Schema = mongoose.Schema

UserSchema = new Schema
  youtubeId: String
  googleId: String
  name: String
  givenName: String
  familyName: String
  link: String
  picture: String
  gender: String
  locale: String

UserSchema.statics.findOrCreateForLogin = (metadata, callback) ->
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

      user.save callback

User = mongoose.model("User", UserSchema)

exports.User = User
