import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/sentinel_service.dart';

final sentinelServiceProvider = Provider<SentinelService>((ref) => SentinelService());

final outbreakMessagesProvider = StreamProvider<List<String>>((ref) {
  return ref.watch(sentinelServiceProvider).getOutbreakMessages();
});