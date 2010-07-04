var http = require('http');
var url = require("url");

var app = require("./app");
var route = app.route;

http.createServer(function(req, res) {
  var handler = route(req.method, req.url);
  handler(req, res);
  res.end();
}).listen(3000);



