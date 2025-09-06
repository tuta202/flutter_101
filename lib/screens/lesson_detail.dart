import 'package:flutter/material.dart';
import '../models/lesson.dart';
import 'listening_screen.dart';
import 'speaking_screen.dart';
import 'reading_screen.dart';
import 'writing_screen.dart';

class LessonDetailScreen extends StatelessWidget {
  final Lesson lesson;
  const LessonDetailScreen({required this.lesson});

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (lesson.skill) {
      case 'listening':
        content = ListeningScreen(audioUrl: lesson.audioUrl);
        break;
      case 'speaking':
        content = const SpeakingScreen();
        break;
      case 'reading':
        content = const ReadingScreen();
        break;
      case 'writing':
        content = const WritingScreen();
        break;
      default:
        content = const Center(child: Text('No content'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(lesson.description),
            const SizedBox(height: 12),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
