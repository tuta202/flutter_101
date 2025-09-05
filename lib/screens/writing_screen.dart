import 'package:flutter/material.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final _textController = TextEditingController();
  final String correctText = 'Hello, how are you?';

  void _checkWriting() {
    final userText = _textController.text.trim();
    final isCorrect = userText.toLowerCase() == correctText.toLowerCase();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isCorrect ? 'Viết đúng!' : 'Sai, đáp án là: $correctText')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kỹ Năng Viết')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Viết câu: "Hello, how are you?"'),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Nhập câu của bạn'),
            ),
            ElevatedButton(onPressed: _checkWriting, child: const Text('Kiểm Tra')),
          ],
        ),
      ),
    );
  }
}