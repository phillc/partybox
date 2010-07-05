var vows = require ('vows'),
    assert = require('assert');
    
var router = require('../../app').router;

vows.describe('Application').addBatch({
  'The Application router': {
    'when going to the home page': {
      topic: function() { return router('GET', '/') },
      'should return a function': function(handler) {
        assert.equal(typeof handler, 'function');
      },
      'that has a 200 response code': function(handler) {}
    },
    'when going to a page that does not exist': {
      topic: function() { return router('GET', '/some_crazy_page_that_does_not_exist'); },
      'should return a function' : function(handler) {
        assert.equal(typeof handler, 'function');
      },
      'that has a 404 response code': function(handler) {}
    }
  }
}).export(module);