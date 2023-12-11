import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unloack/screens/home_page.dart';

import '../db/model/firebase_model/model_destination.dart';

class FavoriteModel extends ChangeNotifier {
  //bool favoritesLoaded = false;
  List<String> favorites = [];
  ValueNotifier<List<ModelDestination>> favoritesListenable = ValueNotifier([]);

  Future<void> initFavorites(String userId) async {
    final favoritesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();
    favorites =
        favoritesSnapshot.docs.map((destination) => destination.id).toList();

    final favoriteDestinations = await Future.wait(favorites.map(
        (destinationId) => FirebaseFirestore.instance
            .collection('destinationCollection')
            .doc(destinationId)
            .get()));

    final favoriteDestinationData = favoriteDestinations.map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>;
      return ModelDestination(
        destinationId: snapshot.id,
        destinationName: data['destination name'],
        districtName: data['district'],
        categoryName: data['category'],
        location: data['location url'],
        destinationDescription: data['description'],
        destinationImage: List<String>.from(data['image urls']),
      );
    }).toList();

    favoritesListenable.value = favoriteDestinationData;
    // favoritesLoaded = true;
    // notifyListeners();
  }

  void addFavorite(String destinationId) {
    if (!favorites.contains(destinationId)) {
      favorites.add(destinationId);
      notifyListeners();
      // Add the favorite to Firebase here using the current user's ID
      if (currentUser!.uid.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .collection('favorites')
            .doc(destinationId)
            .set({'timestamp': FieldValue.serverTimestamp()});
      }
    }
  }

  void removeFavorite(String destinationId) {
    if (favorites.contains(destinationId)) {
      favorites.remove(destinationId);
      notifyListeners();
      // Remove the favorite from Firebase here using the current user's ID
      if (currentUser!.uid.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .collection('favorites')
            .doc(destinationId)
            .delete();
      }
    }
  }
}
