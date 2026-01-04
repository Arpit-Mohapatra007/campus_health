import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/pharmacy_provider.dart';

class InventoryTab extends ConsumerWidget {
  const InventoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryAsync = ref.watch(inventoryProvider);

    return Container(
      color: Colors.white,
      child: inventoryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (meds) {
          if (meds.isEmpty) return const Center(child: Text("Inventory Empty"));
          
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: meds.length,
            itemBuilder: (ctx, i) {
              final med = meds[i];
              final stock = med['stock'] as int;
              final isLow = stock < 20;

              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isLow ? Colors.red[100] : Colors.green[100],
                    child: Icon(Icons.local_pharmacy, color: isLow ? Colors.red : Colors.green),
                  ),
                  title: Text(med['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${med['type']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLow)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text("LOW STOCK", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      const SizedBox(width: 10),
                      Text("$stock", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isLow ? Colors.red : Colors.black)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}