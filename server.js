var http = require('http'),
    url = require('url'),
    sys = require('sys');

var app = require('./app');
var router = app.router;

http.createServer(function(req, res) {
  var handler = router(req.method, req.url);
  handler(req, res);
}).listen(3000);



