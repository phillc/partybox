exports.googleAppId = process.env.PARTYBOX_APP_ID
exports.googleAppSecret = process.env.PARTYBOX_APP_SECRET
exports.youTubeDeveloperKey = process.env.PARTYBOX_DEVELOPER_KEY
exports.redis =
  host: process.env.PARTYBOX_REDIS_URI
  port: process.env.PARTYBOX_REDIS_PORT
  pass: process.env.PARTYBOX_REDIS_AUTH

