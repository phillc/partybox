var mc = exports;

var state = 'Stopped';

mc.states = {
  stopped: 'Stopped'
}

mc.getState = function() { return state; }

mc.play = function() { state = 'Playing'; }