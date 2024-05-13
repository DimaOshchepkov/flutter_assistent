import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/ai.dart';
import 'package:intl/intl.dart';

import 'message.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Message> _messages = <Message>[];
  final _textController = TextEditingController();
  //final fsconnect = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Голосовой помошник')),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _getItem(_messages[index]),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textController,
                    decoration:
                        const InputDecoration(hintText: 'Отправить сообщение'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _senderMessage(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _getItem(Message message) {
    return Container(
      color: message.isSend ? Colors.tealAccent : Colors.limeAccent,
      margin: message.isSend
          ? const EdgeInsets.fromLTRB(80, 8, 4, 4)
          : const EdgeInsets.fromLTRB(4, 8, 80, 4),
      child: message.isSend
          ? _getMyListTile(message)
          : _getAssistentListTile(message),
    );
  }

  ListTile _getMyListTile(Message message) {
    return ListTile(
      leading: Icon(Icons.face),
      title: Text(message.text,
          textAlign: TextAlign.left, style: const TextStyle(fontSize: 18)),
      subtitle: Text(message.date, textAlign: TextAlign.left),
    );
  }

  ListTile _getAssistentListTile(Message message) {
    return ListTile(
        trailing: Icon(Icons.face),
        title: Text(message.text,
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 18)),
        subtitle: Text(message.date, textAlign: TextAlign.right));
  }

  void _senderMessage(String question) async {
    final DateTime questionTime = DateTime.now();
    final String formattedQuestionDate =
        DateFormat('yyyy-MM-dd – kk:mm:ss.SSS').format(questionTime);

    _textController.clear();
    setState(() {
      _messages.insert(0,
          Message(text: question, isSend: true, date: formattedQuestionDate));
    });

    final String answer = await AI().getAnswer(question);
    final DateTime answerTime = DateTime.now();
    final String formattedAnswerDate =
        DateFormat('yyyy-MM-dd – kk:mm:ss.SSS').format(answerTime);

    setState(() {
      _messages.insert(
          0, Message(text: answer, isSend: false, date: formattedAnswerDate));
    });

    /*var dialogue = fsconnect.collection('dialogue');
    await dialogue
        .add({'text': question, 'isSend': true, 'date': questionTime});
    await dialogue.add({'text': answer, 'isSend': false, 'date': answerTime});*/
  }
}
