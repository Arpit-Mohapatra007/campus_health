import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/auth_provider.dart';
import 'tabs/pending_tab.dart';
import 'tabs/queue_tab.dart';
import '../chat/chats_tab.dart';

class DoctorHome extends ConsumerWidget {
  const DoctorHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Doctor Dashboard', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.teal,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(icon: Icon(Icons.assignment_ind_outlined), text: "Requests"),
              Tab(icon: Icon(Icons.people_alt_outlined), text: "Live Queue"),
              Tab(icon: Icon(Icons.chat_bubble_outline), text: "Chats"),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () => ref.read(authServiceProvider).signOut(),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF5F5F5), 
        body: const TabBarView(
          children: [
            PendingRequestsTab(),
            LiveQueueTab(),
            ChatsTab(),
          ],
        ),
      ),
    );
  }
}