var io = require('socket.io').listen(8080)

io.sockets.on('connection', function(socket) {
  socket.emit('init_data', { 
    my_id: socket.id, 
  })

  socket.on('keystroke', function(keystroke) {
    // do stuff in response to keystrokes
  })

  socket.on('disconnect', function(){
    // handle disconnections, remove users, etc
  })

  socket.on('update_position', function(movement) {
    // movement.x
    // movement.y
    // movement.object_id
    console.log(movement)
  })
})
