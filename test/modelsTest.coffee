require("mongoose").connect "mongodb://localhost/partybox_test"
servicesStub = require("./support/servicesStub")
models = require("../models")(servicesStub)
should = require("should")
Charlatan = require("charlatan")

describe "User", ->
  beforeEach (done) ->
    firstName = Charlatan.Name.firstName()
    lastName = Charlatan.Name.lastName()
    @googleUserMetadata =
      id: Charlatan.Helpers.rand(0, 10000).toString()
      name: "#{firstName} #{lastName}"
      given_name: firstName
      family_name: lastName
      link: Charlatan.Internet.domainName()
      picture: "#{Charlatan.Internet.domainName()}/picture.jpg"
      gender: "gender"
      locale: "locale"
    models.User.remove({}, done)

  describe "findOrCreateForLogin", ->
    it "returns a new user", (done) ->
      models.User.findOrCreateForLogin {}, "", (err, user) ->
        should.not.exist(err)
        user.should.have.property("_id")
        done()

    it "stores the google user metadata", (done) ->
      models.User.findOrCreateForLogin @googleUserMetadata, "", (err, user) =>
        should.not.exist(err)
        user.googleId.should.equal @googleUserMetadata.id
        user.name.should.equal @googleUserMetadata.name
        user.givenName.should.equal @googleUserMetadata.given_name
        user.familyName.should.equal @googleUserMetadata.family_name
        user.link.should.equal @googleUserMetadata.link
        user.picture.should.equal @googleUserMetadata.picture
        user.gender.should.equal @googleUserMetadata.gender
        user.locale.should.equal @googleUserMetadata.locale
        done()

    it "returns an existing user", (done) ->
      user = new models.User
      user.googleId = @googleUserMetadata.id

      user.save (err, user) =>
        models.User.findOrCreateForLogin @googleUserMetadata, "", (err, foundUser) ->
          should.not.exist(err)

          foundUser._id.should.eql user._id
          done()

    it "fetches the youtube id", (done) ->
      models.User.findOrCreateForLogin @googleUserMetadata, "", (err, user) =>
        user.youTubeId.should.equal "1234"
        done()


