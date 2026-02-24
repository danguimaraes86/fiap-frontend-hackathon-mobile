import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_preferences_model.dart';

class UserPreferencesService {
  final _preferencesCollection = FirebaseFirestore.instance.collection(
    'user_preferences',
  );
  final _auth = FirebaseAuth.instance;

  String get _currentUserId => _auth.currentUser!.uid;

  Future<UserPreferencesModel> getPreferences() async {
    final snapshot = await _preferencesCollection
        .where('userId', isEqualTo: _currentUserId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return UserPreferencesModel.defaultPreferences;
    }

    final doc = snapshot.docs.first;
    return UserPreferencesModel.fromJson({...doc.data(), 'id': doc.id});
  }

  Future<UserPreferencesModel> createPreferences() async {
    final doc = await _preferencesCollection.add(
      UserPreferencesModel.defaultPreferences
          .copyWith(userId: _currentUserId)
          .toJson(),
    );

    return UserPreferencesModel.defaultPreferences.copyWith(
      id: doc.id,
      userId: _currentUserId,
    );
  }

  Future<void> updatePreferences(UserPreferencesModel preferences) async {
    await _preferencesCollection
        .doc(preferences.id)
        .set(preferences.toJson(), SetOptions(merge: true));
  }
}
