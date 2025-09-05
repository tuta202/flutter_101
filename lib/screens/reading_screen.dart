import 'package:flutter/material.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  int _selectedIndex = -1; // Sử dụng index để quản lý lựa chọn
  final List<String> options = ['London', 'Paris'];
  final String correctAnswer = 'London';

  void _checkAnswer() {
    final isCorrect = _selectedIndex != -1 && options[_selectedIndex] == correctAnswer;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isCorrect ? 'Đúng!' : 'Sai, đáp án là London')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kỹ Năng Đọc')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Đọc đoạn văn: "The capital of England is London."'),
            const Text('Câu hỏi: Thủ đô của England là gì?'),
            ...List.generate(options.length, (index) => RadioListTile<int>(
              title: Text(options[index]),
              value: index,
              groupValue: _selectedIndex,
              onChanged: (value) {
                setState(() {
                  _selectedIndex = value ?? -1;
                });
              },
            )),
            ElevatedButton(onPressed: _checkAnswer, child: const Text('Kiểm Tra')),
          ],
        ),
      ),
    );
  }
}