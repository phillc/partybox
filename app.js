var sys = require("sys");
require('express');

var music_control = require("./lib/music-control"),
    play_list     = require("./lib/playlist");

configure(function(){
  use(Logger)
  use(Static)
  set('root', __dirname)
})



get('/', function(){
  this.render('index.html.haml', {

  });
});

get('/snapshot', function(){
  this.render('index.html.haml', {
    layout: false
  });
});

get('/updates', function(){
  this.render('index.html.haml', {
    layout: false
  });
});



run();