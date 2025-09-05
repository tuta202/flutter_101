import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({super.key});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  final AssetsAudioPlayer _player = AssetsAudioPlayer();
  String _selectedAnswer = '';
  final String correctAnswer = 'Hello';

  void _playAudio() {
    _player.open(Audio('assets/audio/hello.mp3'));
  }

  void _checkAnswer() {
    final isCorrect = _selectedAnswer == correctAnswer;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isCorrect ? 'Đúng!' : 'Sai, đáp án là Hello')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kỹ Năng Nghe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Nghe âm thanh và chọn từ đúng:'),
            ElevatedButton(onPressed: _playAudio, child: const Text('Phát Âm Thanh')),
            RadioListTile<String>(
              title: const Text('Hello'),
              value: 'Hello',
              groupValue: _selectedAnswer,
              onChanged: (value) => setState(() => _selectedAnswer = value!),
            ),
            RadioListTile<String>(
              title: const Text('Goodbye'),
              value: 'Goodbye',
              groupValue: _selectedAnswer,
              onChanged: (value) => setState(() => _selectedAnswer = value!),
            ),
            ElevatedButton(onPressed: _checkAnswer, child: const Text('Kiểm Tra')),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}