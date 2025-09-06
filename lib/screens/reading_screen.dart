import 'package:flutter/material.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  int _selected = -1;
  final options = ['London', 'Paris', 'Berlin'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Read the short paragraph and answer:'),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('London is the capital of the United Kingdom. It has many famous landmarks including the Big Ben and the London Eye.'),
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(options.length, (i) => RadioListTile<int>(
          value: i,
          groupValue: _selected,
          title: Text(options[i]),
          onChanged: (v) => setState(() => _selected = v ?? -1),
        )),
        ElevatedButton(
          onPressed: () {
            final correct = _selected == 0;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(correct ? 'Correct!' : 'Wrong — correct answer is London')));
          },
          child: const Text('Check'),
        ),
      ],
    );
  }
}