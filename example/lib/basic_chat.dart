import 'package:flutter/material.dart';
import 'package:flutter_chat/flutter_chat.dart';

import 'mock/mock_messages.dart';
import 'models/ek_message.dart';
import 'theme/app_theme.dart';

class BasicChat extends StatefulWidget {
  @override
  _BasicChatState createState() => _BasicChatState();
}

class _BasicChatState extends State<BasicChat> {
  final List<EKMessage> _messages = [];

  late Chat chatView;

  @override
  void initState() {
    super.initState();
    setState(() {
      _messages.addAll(generateRandomTextMessages());
    });
  }

  @override
  Widget build(BuildContext context) {
    chatView = _chatWidget(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Chat')),
      body: chatView,
    );
  }

  Chat _chatWidget(BuildContext context) => Chat(
        theme: AppTheme.dark(context),
        messages: _messages,
        messageCellSizeConfigurator:
            MessageCellSizeConfigurator.defaultConfiguration,
        chatMessageInputField: MessageInputField(
          sendButtonTapped: (msg) {
            debugPrint(msg);
            setState(
              () {
                final message = EKMessage(
                  user: randomUser,
                  id: DateTime.now().toString(),
                  isMe: randomUser.userName == outgoing.userName,
                  messageKind: MessageKind.text(msg),
                );
                _messages.insert(0, message);
                chatView.scrollToBottom();
              },
            );
          },
        ),
      );
}