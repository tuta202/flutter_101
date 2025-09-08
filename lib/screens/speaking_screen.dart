import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import '../models/chat_message.dart';
import '../services/mock_service.dart';

class SpeakingScreen extends StatefulWidget {
  const SpeakingScreen({super.key});

  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  late Future<List<ChatMessage>> _future;
  final List<ChatMessage> _messages = [];
  final FlutterTts _tts = FlutterTts();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _lastWords = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _future = Provider.of<MockService>(
      context,
      listen: false,
    ).fetchChatMessages();
  }

  void _toggleMic() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (res) {
            setState(() => _lastWords = res.recognizedWords);
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      if (_lastWords.isNotEmpty) {
        setState(() {
          _messages.add(
            ChatMessage(
              id: DateTime.now().millisecondsSinceEpoch,
              message: _lastWords,
              role: "user",
            ),
          );
          _lastWords = "";
        });
      }
    }
  }

  Future<void> _speak(String text) async {
    await _tts.setLanguage("en-US"); // vi-VN
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.9);
    await _tts.setVolume(1.0);
    await _tts.speak(text);
  }

  Widget _buildBubble(ChatMessage msg, ThemeData theme) {
    final isUser = msg.role == "user";

    // Bubble container
    final bubble = Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      constraints: const BoxConstraints(maxWidth: 260),
      decoration: BoxDecoration(
        color: isUser ? theme.colorScheme.primary : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: isUser
              ? const Radius.circular(16)
              : const Radius.circular(4),
          bottomRight: isUser
              ? const Radius.circular(4)
              : const Radius.circular(16),
        ),
        boxShadow: isUser
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Text(
        msg.message,
        style: TextStyle(
          color: isUser ? Colors.white : Colors.black87,
          fontSize: 15,
        ),
      ),
    );

    // Speaker icon
    final speakerIcon = IconButton(
      icon: Icon(
        Icons.volume_up,
        size: 22,
        color: isUser ? theme.colorScheme.primary : theme.colorScheme.secondary,
      ),
      onPressed: () => _speak(msg.message),
    );

    return Row(
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: isUser
          ? [speakerIcon, bubble] // user: icon bên trái bubble
          : [bubble, speakerIcon], // assistant: icon bên phải bubble
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: FutureBuilder<List<ChatMessage>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && _messages.isEmpty) {
            _messages.addAll(snapshot.data!);
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: _messages.length,
                  itemBuilder: (ctx, i) => _buildBubble(_messages[i], theme),
                ),
              ),
              if (_lastWords.isNotEmpty && _isListening)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Listening: $_lastWords",
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              const SizedBox(height: 70),
            ],
          );
        },
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: _toggleMic,
          child: Icon(
            _isListening ? Icons.mic : Icons.mic_none,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
