import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeakingScreen extends StatefulWidget {
  const SpeakingScreen({super.key});

  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Nhấn để nói';
  final String targetWord = 'Hello';

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    await Permission.microphone.request();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          setState(() => _text = result.recognizedWords);
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      _checkPronunciation();
    }
  }

  void _checkPronunciation() {
    final isCorrect = _text.toLowerCase().contains(targetWord.toLowerCase());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isCorrect ? 'Phát âm đúng!' : 'Thử lại, từ mục tiêu là Hello')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kỹ Năng Nói')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Nói từ "Hello" và kiểm tra:'),
            Text(_text),
            ElevatedButton(
              onPressed: _listen,
              child: Text(_isListening ? 'Dừng' : 'Bắt Đầu Nói'),
            ),
          ],
        ),
      ),
    );
  }
}