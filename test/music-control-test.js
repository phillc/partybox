var vows = require ('vows'),
    assert = require('assert');

var musicControl = require('../music-control');

vows.describe('Music Control').addBatch({
  'The Music Control': {
    topic: function() { return musicControl; },
    'is initially stopped': function(mc) {
      assert.equal(mc.getState(), 'Stopped');
    },
    'when Played': {
      topic: function(mc) { mc.play(); return mc; },
      'will change its state': function(mc) {
        assert.equal(mc.getState(), 'Playing');
      }
    }
  }
}).export(module);
