var sys = require("sys");
var readFile = require("fs").readFile;

var render_static = function(filename) { 
  return function(req, res) {
    sys.puts("loading static file: " + filename);
    readFile("static/" + filename, function(err, data) {
      if(err) {
        sys.puts("Error loading " + filename);
        sys.puts(err);
      } else {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.write(data);
        res.end();
      }
    }); 
  }
}

var updates = function(req, res) {
  res.writeHead(200, {'Content-Type': 'application/json'});
  // var messages = look_up(since));
  res.write('[]');
  res.end();
}

var http404 = function(req, res) {
  sys.puts("page not found: " + req.url);
  res.writeHead(404, {'Content-Type': 'text/html'});
  res.write("page not found");
  res.end();
}

var routes = {
  get: {
    '/': render_static('index.html'),
    '/updates': updates
  },
  post: {
    '/play': function(req, res) {
    }
  }
}


exports.router = function(method, url){
  sys.puts("request " + method + ": " + url);
  
  var handler;
  
  if(method == "GET") {
    handler = routes.get[url];
  } else if(method == "POST") {
    handler = routes.post[url];
  }
  
  handler = handler || http404;
  return handler;
}
