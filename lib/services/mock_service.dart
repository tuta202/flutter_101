import 'dart:async';
import '../models/lesson.dart';

class MockService {
  // pretend to fetch lessons (could be replaced with real API)
  Future<List<Lesson>> fetchLessons() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      Lesson(
        id: 'l1',
        title: 'Basics: Greetings',
        description: 'Say hello, introduce yourself and ask wellbeing.',
        skill: 'speaking',
        progress: 20,
        audioUrl: '',
      ),
      Lesson(
        id: 'l2',
        title: 'Listening: Short Conversations',
        description: 'Practice listening to short daily dialogs.',
        skill: 'listening',
        progress: 40,
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      ),
      Lesson(
        id: 'l3',
        title: 'Reading: City Guide',
        description: 'Read a short city guide and answer questions.',
        skill: 'reading',
        progress: 70,
      ),
      Lesson(
        id: 'l4',
        title: 'Writing: Simple Emails',
        description: 'Learn structure of short emails and practice writing.',
        skill: 'writing',
        progress: 10,
      ),
    ];
  }

  Future<void> fakeLogin(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 350));
    if (username != 'admin' || password != '123456') {
      throw Exception('Invalid credentials');
    }
  }
}