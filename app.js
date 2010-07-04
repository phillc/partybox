var sys = require("sys");
var readFile = require("fs").readFile;

var routes = {
  get: {
    '/': render_static('index.html')
  },
  post: {
    '/play': function(req, res) {
    },
  }
}

function render_static(filename) { 
  return function(req, res) {
    sys.puts("loading static file: " + filename);
    readFile("lib/" + file, function(err, data) {
      if(err) {
        sys.puts("Error loading " + filename);
        sys.puts(err);
      } else {
        res.writeHead(200, {'Content-Type': 'text/plain'});
        res.write('Party Box');
      }
    }
  }
}

exports.route = function(method, url){
  if(method == "GET") {
    routes.get[url];
  } else if(method == "POST") {
  
  } else {
    //unsupported method
  }
}
