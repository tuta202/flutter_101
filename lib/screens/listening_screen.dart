import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

class ListeningScreen extends StatefulWidget {
  final String audioUrl;
  const ListeningScreen({this.audioUrl = '', super.key});
  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  final AudioPlayer _player = AudioPlayer();
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    if (widget.audioUrl.isNotEmpty) {
      _player.setUrl(widget.audioUrl);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _toggle() async {
    if (_playing) {
      await _player.pause();
    } else {
      await _player.play();
    }
    setState(() => _playing = !_playing);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // bọc để tránh tràn màn hình
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 👉 Animation micro
          SizedBox(
            height: 150,
            child: Lottie.asset("assets/animations/mic.json"),
          ),
          const SizedBox(height: 16),

          const Text(
            'Listen and choose the correct phrase:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: widget.audioUrl.isEmpty ? null : _toggle,
            icon: Icon(_playing ? Icons.pause_circle : Icons.play_circle),
            label: Text(_playing ? 'Pause' : 'Play audio'),
          ),
          const SizedBox(height: 18),

          // mock question
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  const Text('What did you hear?'),
                  const SizedBox(height: 8),
                  _AnswerOption(text: 'Hello', correct: true),
                  _AnswerOption(text: 'Goodbye', correct: false),
                  _AnswerOption(text: 'Thanks', correct: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerOption extends StatefulWidget {
  final String text;
  final bool correct;
  const _AnswerOption({required this.text, required this.correct});
  @override
  State<_AnswerOption> createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<_AnswerOption> {
  bool answered = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.text),
      trailing: answered ? const Icon(Icons.check) : null,
      onTap: answered
          ? null
          : () {
              setState(() => answered = true);
              final isCorrect = widget.correct;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isCorrect ? 'Correct!' : 'Wrong — try again'),
                ),
              );
            },
    );
  }
}
