class ChatMessage {
  final int id;
  final String message;
  final String role; // 'user' | 'assistant'

  ChatMessage({
    required this.id,
    required this.message,
    required this.role,
  });
}