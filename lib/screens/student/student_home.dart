import 'package:campus_health/widgets/live_queue_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/auth_provider.dart';

class StudentHome extends ConsumerWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authServiceProvider).signOut(),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            const LiveQueueCard(),
            const SizedBox(height: 20),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _HomeButton(
                    icon: Icons.calendar_month,
                    label: "Book Appointment",
                    color: Colors.teal,
                    onTap: () => context.push('/student/bookAppointment'),
                  ),
                  const SizedBox(height: 15),
                  _HomeButton(
                    icon: Icons.chat,
                    label: "My Chats",
                    color: Colors.blue,
                    onTap: () => context.push('/student/chats'), 
                  ),
                  const SizedBox(height: 15),
                 _HomeButton(
                    icon: Icons.history_edu,
                    label: "Medical History",
                    color: Colors.indigo,
                    onTap: () => context.push('/student/history'), 
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _HomeButton({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 28),
        label: Text(label, style: const TextStyle(fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
      ),
    );
  }
}