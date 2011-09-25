var io = require('socket.io').listen(8080)

var users = {}

io.sockets.on('connection', function(socket) {
  socket.emit('init_data', { 
    my_id: socket.id, 
  })

  socket.on('register_user', function(data)  {
    display_graph_id = data.display_graph_id
    if(!users.hasOwnProperty(display_graph_id))  {
      users[display_graph_id] = new Array()
    }
    users[display_graph_id].push(socket)
  })

  socket.on('structure_changes', function(data)  {
    display_graph_id = data.display_graph_id
    for(var i = 0; i < users[display_graph_id].length; i++)  {
      //probably don't want to send the update to yourself
      if(users[display_graph_id][i] != socket)  {
        users[display_graph_id][i].emit('structure_changes', data)
      }
    }
  })

  socket.on('disconnect', function(){
    //remove the user from all display graphs
    //hopefully only on one
    for(var display_graph_id in users)  {
      for(var i = 0; i < users[display_graph_id].length; i++)  {
        if(users[display_graph_id][i] == socket)  {
          //delete the record, then update the array
          users[display_graph_id].splice(i, 1)
        }
      }
    }
  })
})
