import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const LOCAL_HOST_IP = '192.168.225.60';
const PORT = '3000';

const URL = 'ws://$LOCAL_HOST_IP:$PORT';

final WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(URL));

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Simple Chat Using Socket"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  labelText: "Enter the text message",
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                if (textEditingController.text.isNotEmpty) {
                  channel.sink.add(textEditingController.text);
                }
              },
              child: Text('Send'),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: StreamBuilder(
                stream: channel.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    message = 'There is no data';
                  } else {
                    message = snapshot.data.toString();
                  }
                  return Text(message);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
