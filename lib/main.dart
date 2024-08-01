import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: GoRouter(
        debugLogDiagnostics: true,
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            name: 'chat',
            path: '/chat',
            builder: (context, state) => const ChatPage(),
          ),
          GoRoute(
            name: 'chatOpen',
            path: '/chat/:id',
            pageBuilder: (context, state) {
              final id = state.pathParameters['id'];

              return NoTransitionPage(child: ChatPage(id: id));
            },
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Test')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed('chat'),
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.id});

  final String? id;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    log('ChatPage Opened');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Row(
        children: [
          const SizedBox(width: 300, child: ChatList()),
          if (widget.id != null) Expanded(child: ChatView(id: widget.id!)),
        ],
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) {
        return ListTile(
          onTap: () => context.goNamed(
            'chatOpen',
            pathParameters: {'id': '$i'},
          ),
          title: Text('Chat $i'),
          subtitle: Text('Sample $i'),
          trailing: const Icon(Icons.navigate_next),
        );
      },
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(id));
  }
}

/*
  [GoRouter] setting initial location null
  [GoRouter] Using MaterialApp configuration
  [GoRouter] getting location for name: "chat"
  [GoRouter] going to /chat
  [log] ChatPage Opened
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 0}
  [GoRouter] going to /chat/0
  [log] ChatPage Opened
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 1}
  [GoRouter] going to /chat/1
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 1}
  [GoRouter] going to /chat/1
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 2}
  [GoRouter] going to /chat/2
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 3}
  [GoRouter] going to /chat/3
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 4}
  [GoRouter] going to /chat/4
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 5}
  [GoRouter] going to /chat/5
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 6}
  [GoRouter] going to /chat/6
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 7}
  [GoRouter] going to /chat/7
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 8}
  [GoRouter] going to /chat/8
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 9}
  [GoRouter] going to /chat/9
  [GoRouter] getting location for name: "chatOpen", pathParameters: {id: 11}
  [GoRouter] going to /chat/11
*/