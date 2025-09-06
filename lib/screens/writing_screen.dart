import 'package:flutter/material.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final _ctrl = TextEditingController();
  final _target = 'Hello, how are you?';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Write the sentence shown:'),
        const SizedBox(height: 12),
        Card(child: Padding(padding: const EdgeInsets.all(12.0), child: Text(_target))),
        const SizedBox(height: 12),
        TextField(controller: _ctrl, maxLines: 3, decoration: const InputDecoration(hintText: 'Type here...')),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            final ok = _ctrl.text.trim().toLowerCase() == _target.toLowerCase();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? 'Nice job!' : 'Not exact — keep practicing')));
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}