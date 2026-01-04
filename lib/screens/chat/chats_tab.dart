import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/chat_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart'; 

class ChatsTab extends ConsumerWidget {
  const ChatsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myChatsAsync = ref.watch(myChatsProvider);
    final currentUser = ref.watch(authServiceProvider).currentUser;
    final userRole = ref.watch(currentUserProfileProvider).value?.role; 

    return myChatsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text("Error: $err")),
      data: (chats) {
        if (chats.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_bubble_outline, size: 50, color: Colors.grey),
                SizedBox(height: 10),
                Text("No active chats."),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12), 
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            
            final isMeDoctor = currentUser?.uid == chat.doctorId;
            final otherName = isMeDoctor ? chat.studentName : chat.doctorName;
            
            String timeStr = "";
             timeStr = DateFormat('h:mm a').format(chat.lastMessageTime.toDate());
                    
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal.shade100,
                  child: Text(
                    otherName.isNotEmpty ? otherName[0].toUpperCase() : "?", 
                    style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)
                  ),
                ),
                title: Text(otherName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                subtitle: Text(
                  chat.lastMessage, 
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: Text(timeStr, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                onTap: () {
                  final basePath = userRole == 'student' ? '/student' : '/doctor';
                  
                  context.push(
                    '$basePath/chat', 
                    extra: {
                      'chatId': chat.id,
                      'otherUserName': otherName,
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}