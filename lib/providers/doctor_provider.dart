import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/doctor_service.dart';
import 'user_provider.dart';

final doctorServiceProvider = Provider<DoctorService>((ref) {
  return DoctorService();
});

final pendingAppointmentsProvider = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  final service = ref.watch(doctorServiceProvider);
  final user = ref.watch(currentUserProfileProvider).value;

  if (user == null || user.specialization == null) {
    return const Stream.empty();
  }

  return service.getPendingAppointments(user.specialization!);
});

final approvedQueueProvider = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  final service = ref.watch(doctorServiceProvider);
  return service.getApprovedQueue();
});

final allDoctorsProvider = StreamProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
  return ref.watch(doctorServiceProvider).getAllDoctors();
});