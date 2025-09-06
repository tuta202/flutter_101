class Lesson {
  final String id;
  final String title;
  final String description;
  final String skill; // listening, speaking, reading, writing
  final int progress; // 0-100
  final String audioUrl; // optional for listening mock

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.skill,
    required this.progress,
    this.audioUrl = '',
  });
}