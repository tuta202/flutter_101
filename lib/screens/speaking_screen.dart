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
  bool _isAvailable = false;
  bool _isListening = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await Permission.microphone.request();
    final available = await _speech.initialize();
    setState(() => _isAvailable = available);
  }

  void _toggleListen() async {
    if (!_isAvailable) return;
    if (!_isListening) {
      await _speech.listen(onResult: (r) {
        setState(() {
          _lastWords = r.recognizedWords;
        });
      });
    } else {
      await _speech.stop();
    }
    setState(() => _isListening = !_isListening);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Practice speaking — press and speak'),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
          label: Text(_isListening ? 'Stop' : 'Start'),
          onPressed: _toggleListen,
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(_lastWords.isEmpty ? 'Your spoken words will appear here' : _lastWords),
          ),
        ),
      ],
    );
  }
}