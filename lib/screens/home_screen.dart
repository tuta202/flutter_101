import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../services/mock_service.dart';
import '../models/lesson.dart';
import '../widgets/lesson_card.dart';
import 'lesson_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Lesson>> _lessonsFuture;

  @override
  void initState() {
    super.initState();
    final svc = Provider.of<MockService>(context, listen: false);
    _lessonsFuture = svc.fetchLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Learner'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // top greeting + animation
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello, Learner!', style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 6),
                      Text('Practice a little every day — progress is progress.', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                SizedBox(
                  width: 92,
                  height: 92,
                  child: Lottie.asset('assets/animations/learning.json', fit: BoxFit.cover),
                ),
              ],
            ),
            const SizedBox(height: 18),
            // quick skills row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _SkillChip(skill: 'Listening', icon: Icons.headset),
                _SkillChip(skill: 'Speaking', icon: Icons.mic),
                _SkillChip(skill: 'Reading', icon: Icons.menu_book),
                _SkillChip(skill: 'Writing', icon: Icons.edit),
              ],
            ),
            const SizedBox(height: 18),
            // lessons list
            Expanded(
              child: FutureBuilder<List<Lesson>>(
                future: _lessonsFuture,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final lessons = snap.data ?? [];
                  return ListView.separated(
                    itemCount: lessons.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (ctx, i) {
                      final lesson = lessons[i];
                      return LessonCard(
                        lesson: lesson,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: lesson))),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String skill;
  final IconData icon;
  const _SkillChip({required this.skill, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 26, backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12), child: Icon(icon, color: Theme.of(context).colorScheme.primary)),
        const SizedBox(height: 8),
        Text(skill, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}