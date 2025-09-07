import 'dart:async';
import '../models/lesson.dart';
import '../models/notification_item.dart';
import '../models/chat_message.dart';

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
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      ),
      Lesson(
        id: 'l3',
        title: 'Speaking: Daily Situations',
        description: 'Practice speaking in common daily situations.',
        skill: 'speaking',
        progress: 30,
      ),
      Lesson(
        id: 'l4',
        title: 'Reading: City Guide',
        description: 'Read a short city guide and answer questions.',
        skill: 'reading',
        progress: 70,
      ),
      Lesson(
        id: 'l5',
        title: 'Writing: Simple Emails',
        description: 'Learn structure of short emails and practice writing.',
        skill: 'writing',
        progress: 10,
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
    await Future.delayed(const Duration(milliseconds: 500));
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

  Future<List<ChatMessage>> fetchChatMessages() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      ChatMessage(
        id: 1,
        message: "Hello! How are you today?",
        role: "assistant",
      ),
      ChatMessage(
        id: 2,
        message: "I’m fine, thank you. And you?",
        role: "user",
      ),
      ChatMessage(
        id: 3,
        message: "Great! Let’s practice some English speaking.",
        role: "assistant",
      ),
      ChatMessage(
        id: 4,
        message: "Sure! What topic do you want to talk about?",
        role: "user",
      ),
      ChatMessage(
        id: 5,
        message: "How about we start with daily routines?",
        role: "assistant",
      ),
      ChatMessage(
        id: 6,
        message: "Good idea. I usually wake up at 6 a.m. What about you?",
        role: "user",
      ),
      ChatMessage(
        id: 7,
        message: "I usually wake up at 7 a.m. and then I go jogging.",
        role: "assistant",
      ),
      ChatMessage(
        id: 8,
        message: "Nice! After jogging, do you have breakfast?",
        role: "user",
      ),
      ChatMessage(
        id: 9,
        message: "Yes, I usually eat some bread and eggs. What do you eat?",
        role: "assistant",
      ),
      ChatMessage(
        id: 10,
        message: "I often eat rice with vegetables in the morning.",
        role: "user",
      ),
      ChatMessage(
        id: 11,
        message: "That sounds healthy. Do you drink coffee or tea?",
        role: "assistant",
      ),
      ChatMessage(
        id: 12,
        message: "I prefer tea. Coffee makes me too nervous.",
        role: "user",
      ),
      ChatMessage(
        id: 13,
        message: "I see. Tea is good for health. Do you drink it every day?",
        role: "assistant",
      ),
      ChatMessage(
        id: 14,
        message: "Yes, almost every day. It helps me stay focused.",
        role: "user",
      ),
      ChatMessage(
        id: 15,
        message: "Great! I think you’re doing very well in English practice.",
        role: "assistant",
      ),
    ];
  }
}
