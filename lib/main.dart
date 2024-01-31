import 'package:flutter/material.dart';
import 'package:integrations/service/platform_view.dart';
import 'package:integrations/service/service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _service = PlatformService();
  final _textController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(child: PlatformWidget()),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: 'Input message'),
              onSubmitted: (value) {
                _service.sendMessage(value);
              },
            ),
            ElevatedButton(
              onPressed: () async {
                _service.sendMessage(_textController.text);
              },
              child: const Text('Get Platform Text View'),
            ),
          ],
        ),
      ),
    );
  }
}
