var WebSocket = require('ws');
console.log('Server running now');

var port = 3000;

var server = new WebSocket.Server(
    { 
        port: port,
     }
     )


server.on('connection', function connection(client){

    client.on('message', function incoming(message){

        for(var iclient of server.clients)
        {
            iclient.send(message);
        }
    });
});