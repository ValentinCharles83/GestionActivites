import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserPreferencesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> getUserPreferences() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Utilisateur non connecté');
    }
    final prefsSnapshot = await FirebaseFirestore.instance
        .collection('utilisateurs')
        .doc(user.uid)
        .collection('preferences')
        .orderBy('timestamp', descending: true) // Les plus récentes d'abord
        .limit(1) // Récupère seulement la dernière préférence
        .get();

    if (prefsSnapshot.docs.isNotEmpty) {
      return {'typePrefere': prefsSnapshot.docs.first.data()['type']};
    } else {
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getSuggestedActivities() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Utilisateur non connecté');
    }
    final prefsSnapshot = await FirebaseFirestore.instance
        .collection('utilisateurs')
        .doc(user.uid)
        .collection('preferences')
        .orderBy('timestamp', descending: true)
        .get();

    // Utilisez un Set pour éviter les duplications
    Set<String> seenActivityIds = Set();
    List<Map<String, dynamic>> activitiesDetails = [];

    for (var doc in prefsSnapshot.docs) {
      String activityId = doc.data()['activityId'] as String;
      // Vérifiez si l'ID a déjà été traité
      if (!seenActivityIds.contains(activityId)) {
        seenActivityIds.add(activityId); // Marquez l'ID comme traité
        var activitySnapshot = await FirebaseFirestore.instance
            .collection('activites')
            .doc(activityId)
            .get();
        if (activitySnapshot.exists) {
          var data = activitySnapshot.data()!;
          data['id'] = activitySnapshot.id; // Ajoutez l'ID ici
          activitiesDetails.add(data);
        }
      }
    }

    return activitiesDetails;
  }
}
