import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'listening_screen.dart';
import 'speaking_screen.dart';
import 'reading_screen.dart';
import 'writing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Học Tiếng Anh')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animation chào mừng bằng Lottie
            Lottie.asset('assets/animations/welcome.json', width: 200, height: 200),
            const Text('Chào mừng! Chọn kỹ năng để học:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ListeningScreen())),
              child: const Text('Listening (Nghe)'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SpeakingScreen())),
              child: const Text('Speaking (Nói)'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ReadingScreen())),
              child: const Text('Reading (Đọc)'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WritingScreen())),
              child: const Text('Writing (Viết)'),
            ),
          ],
        ),
      ),
    );
  }
}