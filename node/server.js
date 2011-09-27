var io = require('socket.io').listen(8080)

var users = {}
var graph_structures = {}

io.sockets.on('connection', function(socket) {
  socket.emit('init_data', { 
    my_id: socket.id, 
  })

  socket.on('register_user', function(data)  {
    display_graph_id = data.display_graph_id

    //create the display graph user group
    if(!users.hasOwnProperty(display_graph_id))  {
      users[display_graph_id] = new Array()
    }

    //create the graph structure group
    if(!graph_structures.hasOwnProperty(display_graph_id))  {
      graph_structures[display_graph_id] = {}
    }

    //add the user
    users[display_graph_id].push(socket)
    //update the graph to the current state
    socket.emit('structure_changes', {changes: graph_structures[display_graph_id]})
  })

  socket.on('structure_changes', function(data)  {
    display_graph_id = data.display_graph_id

    //save the changes to the graph structure
    //overwrite any previous changes
    for(var node_id in data.changes)  {
      graph_structures[display_graph_id][node_id] = data.changes[node_id]
    }
    
    //send updates to all the users
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
    //if there are no users, remove the display graph structure and user group
  })
})
