import 'dart:async';
import '../models/lesson.dart';
import '../models/notification_item.dart';
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
      Lesson(
        id: 'l5',
        title: 'Speaking: Daily Situations',
        description: 'Practice speaking in common daily situations.',
        skill: 'speaking',
        progress: 30,
      ),
      Lesson(
        id: 'l6',
        title: 'TOEIC: Listening Practice',
        description: 'Listen to short TOEIC-style recordings.',
        skill: 'listening',
        progress: 50,
      ),
      Lesson(
        id: 'l7',
        title: 'TOEIC: Reading Practice',
        description: 'Read passages and answer TOEIC questions.',
        skill: 'reading',
        progress: 25,
      ),

    ];
  }

  Future<void> fakeLogin(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 350));
    if (username != 'admin' || password != '123456') {
      throw Exception('Invalid credentials');
    }
  }

  Future<List<NotificationItem>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      NotificationItem(
        id: 'n1',
        title: 'Welcome 🎉',
        body: 'Chúc mừng bạn đã bắt đầu hành trình học tiếng Anh!',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      NotificationItem(
        id: 'n2',
        title: 'Daily reminder',
        body: 'Hãy hoàn thành ít nhất 1 bài học hôm nay để giữ streak 🔥',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      NotificationItem(
        id: 'n3',
        title: 'New Lesson Available',
        body: 'Một bài học mới về Speaking vừa được thêm!',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }
}