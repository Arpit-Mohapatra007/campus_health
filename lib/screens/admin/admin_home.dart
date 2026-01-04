import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/auth_provider.dart';
import 'tabs/sentinel_tab.dart';
import 'tabs/inventory_tab.dart';

class AdminHome extends ConsumerWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("ADMIN CONSOLE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          backgroundColor: Colors.blueGrey[900], 
          foregroundColor: Colors.white,
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.redAccent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.shield), text: "Sentinel"),
              Tab(icon: Icon(Icons.medication), text: "Inventory"),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => ref.read(authServiceProvider).signOut(),
            ),
          ],
        ),
        body: const TabBarView(
          children: [
            SentinelTab(),
            InventoryTab(),
          ],
        ),
      ),
    );
  }
}