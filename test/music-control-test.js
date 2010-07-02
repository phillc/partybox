var vows = require ('vows'),
    assert = require('assert');

var musicControl = require('../music-control');

vows.describe('Music Control').addBatch({
  'The Music Control': {
    topic: function() { return musicControl; },
    'will play': function(mc) {
      assert.equal(mc.state, 'Playing');
    }
  }
}).export(module);
