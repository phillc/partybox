var states = {
  stopped: 'Stopped',
  paused: 'Paused',
  playing: 'Playing'
}

var mc = function() {
  this.state = states.stopped;
};

mc.prototype.getState = function() { return this.state; }

mc.prototype.play = function() { this.state = states.playing; }

mc.prototype.stop = function() { this.state = states.stopped; }

mc.prototype.pause = function() { this.state = states.paused; }

module.exports = mc;