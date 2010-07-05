var client = new function() {
  var _poll = function() {
    $.get('/updates', function(messages) {
      console.log(messages);
    });
  }
  $.get('/snapshot', function(state) {
    last_message = state.last_message;
    _poll();
  });
}

var set_control_buttons(buttons) {
  console.log(
  $('control-buttons > input[play]')
)
}
var playing = function(current_track) {
  
};
