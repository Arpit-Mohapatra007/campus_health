import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/pharmacy_service.dart';

final pharmacyServiceProvider = Provider<PharmacyService>((ref) => PharmacyService());

final inventoryProvider = StreamProvider<List<Map<String, dynamic>>>((ref) {
  return ref.watch(pharmacyServiceProvider).getInventory();
});