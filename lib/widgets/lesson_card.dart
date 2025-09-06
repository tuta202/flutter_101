import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback? onTap;
  const LessonCard({required this.lesson, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              _SkillBadge(skill: lesson.skill, progress: lesson.progress),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(lesson.title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(lesson.description, style: Theme.of(context).textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(value: lesson.progress/100),
                ]),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillBadge extends StatelessWidget {
  final String skill;
  final int progress;
  const _SkillBadge({required this.skill, required this.progress});
  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (skill) {
      case 'listening': icon = Icons.headset; break;
      case 'speaking': icon = Icons.mic; break;
      case 'reading': icon = Icons.menu_book; break;
      case 'writing': icon = Icons.edit; break;
      default: icon = Icons.school;
    }
    return Column(
      children: [
        CircleAvatar(child: Icon(icon, size: 18), radius: 26),
        const SizedBox(height: 6),
        Text('$progress%', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}