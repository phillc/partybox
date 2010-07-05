var vows = require ('vows'),
    assert = require('assert');

var musicControl = require('../../lib/music-control');

vows.describe('Music Control').addBatch({
  'The Music Control': {
    'initially': {
      topic: new(musicControl),
      'is stopped': function(mc) {
        assert.equal(mc.getState(), 'Stopped');
      },
    },
    'when played': {
      topic: function() {
        mc = new(musicControl);
        mc.play();
        return mc;
      },
      'reflects its state': function(mc) {
        assert.equal(mc.getState(), 'Playing');
      }
    },
    'when paused': {
      topic: function() {
        mc = new(musicControl);
        mc.pause();
        return mc;
      },
      'reflects its state': function(mc) {
        assert.equal(mc.getState(), 'Paused');
      }
    }
  }
}).export(module);
