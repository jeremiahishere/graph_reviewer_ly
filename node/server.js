var io = require('socket.io').listen(8080)

io.sockets.on('connection', function(socket) {
  socket.emit('init_data', { 
    my_id: socket.id, 
  })

  socket.on('register_user', function(data)  {
    //this should add a user to the user list
    //by socket id and display graph id

    console.log("user registered")
    console.log(data)
  })

  socket.on('structure_changes', function(data)  {
    //this only theoretically works at the most basic possible level
    /*for(var id in users)  {
      if(users[id].display_graph_id == data.display_graph_id)  {
        users[id].socket.emit('structure_changes', data)
      }
    }*/
    console.log("structure change from user")
    console.log(data)
  })

  /*socket.on('keystroke', function(keystroke) {
    // do stuff in response to keystrokes
  })*/

  socket.on('disconnect', function(){
    // handle disconnections, remove users, etc
  })

  /*socket.on('update_position', function(movement) {
    // movement.x
    // movement.y
    // movement.object_id
    console.log(movement)
  })*/
})
