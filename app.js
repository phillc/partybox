var sys = require("sys");
var readFile = require("fs").readFile;

require('express');

configure(function(){
  set('root', __dirname)
})

get('/', function(){
  this.render('index.html.haml', {
    layout: false
  })
})

run();