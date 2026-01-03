import 'package:cloud_firestore/cloud_firestore.dart';

class PharmacyService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getInventory() {
    return _db.collection('inventory')
        .where('stock', isGreaterThan: 0)
        .orderBy('stock') 
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => {
              ...doc.data(),
              'id': doc.id,
            }).toList());
  }

  Future<void> submitPrescription({
    required String appointmentId,
    required String studentId,
    required String studentName,
    required String doctorId,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
  }) async {
    await _db.runTransaction((transaction) async {
      final presRef = _db.collection('prescriptions').doc();
      transaction.set(presRef, {
        'appointmentId': appointmentId,
        'studentId': studentId,
        'studentName': studentName,
        'doctorId': doctorId,
        'diagnosis': diagnosis,
        'medicines': medicines,
        'timestamp': FieldValue.serverTimestamp(),
      });

      for (var med in medicines) {
        final medRef = _db.collection('inventory').doc(med['id']);
        final medDoc = await transaction.get(medRef);
        if (medDoc.exists) {
          final currentStock = medDoc.data()!['stock'] as int;
          final newStock = currentStock - (med['qty'] as int);
          transaction.update(medRef, {'stock': newStock});
        }
      }

      final appRef = _db.collection('appointments').doc(appointmentId);
      transaction.update(appRef, {'status': 'completed'});
    });
  }
}