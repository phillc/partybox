server = require("./server")
config = require("./config")

server.configure(config)
server.boot()
