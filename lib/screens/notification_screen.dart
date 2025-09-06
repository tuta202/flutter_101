import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/notification_item.dart';
import '../services/mock_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationItem>> _future;

  @override
  void initState() {
    super.initState();
    _future = Provider.of<MockService>(
      context,
      listen: false,
    ).fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
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
      body: FutureBuilder<List<NotificationItem>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snap.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text("Không có thông báo nào"));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (context, i) {
              final n = items[i];
              return ListTile(
                leading: Icon(
                  n.read ? Icons.mark_email_read : Icons.notifications_active,
                  color: n.read
                      ? Colors.grey
                      : Theme.of(context).colorScheme.primary,
                ),
                title: Text(n.title),
                subtitle: Text(n.body),
                trailing: Text(
                  "${n.createdAt.hour.toString().padLeft(2, '0')}:${n.createdAt.minute.toString().padLeft(2, '0')}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Đã mở: ${n.title}")));
                },
              );
            },
          );
        },
      ),
    );
  }
}
