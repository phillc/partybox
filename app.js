var sys = require("sys");
var readFile = require("fs").readFile;

require('express')

get('/', function(){
  return "Party Box";
})

run();