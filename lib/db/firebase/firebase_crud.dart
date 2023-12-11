import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unloack/db/firebase/response.dart';
import 'package:unloack/db/model/firebase_model/model_destination.dart';
import 'package:unloack/widgets/category_card.dart';
import 'package:unloack/widgets/districts_checkbox.dart';

final ValueNotifier<List<ModelDestination>> allDestinations =
    ValueNotifier<List<ModelDestination>>([]);

final ValueNotifier<List<ModelDestination>> filterNotifier =
    ValueNotifier<List<ModelDestination>>([]);

final ValueNotifier<List<ModelDestination>> ramdomListNotifier =
    ValueNotifier<List<ModelDestination>>([]);

final CollectionReference destinationReference =
    FirebaseFirestore.instance.collection('destinationCollection');

class DestinationRepository {
  //add destination
  addDestinationToFirebase({
    required destinationName,
    required districtName,
    required categoryName,
    required location,
    required destinationDescription,
    required List<String> destinationImageUrl,
    bool isFavorite = false,
  }) async {
    Response response = Response();
    DocumentReference newDestination = destinationReference.doc();
    Map<String, dynamic> newDestinationDetails = {
      'id': newDestination.id,
      'destination name': destinationName,
      'district': districtName,
      'category': categoryName,
      'location url': location,
      'description': destinationDescription,
      'image urls': destinationImageUrl,
    };
    await newDestination.set(newDestinationDetails).whenComplete(() {
      response.code = 200;
      response.message = 'Successfully added to the database';
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });
    return response;
  }
  //add destination

  //delete destination
  deleteDestinationFromFirebase(String id) async {
    await destinationReference.doc(id).delete();
  }
  //delete destination

  //fetch data
  Future<List<ModelDestination>> fetchDestinations() async {
    final querySnapshot = await destinationReference.get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ModelDestination(
        destinationId: doc.id,
        destinationName: data['destination name'],
        districtName: data['district'],
        categoryName: data['category'],
        location: data['location url'],
        destinationDescription: data['description'],
        destinationImage: List<String>.from(data['image urls']),
      );
    }).toList();
  }
  //fetch data

  //get the data from fectch destination
  void getAllDestinations() async {
    final destinationList = await fetchDestinations();
    allDestinations.value = destinationList;
  }
  //get the data from fectch destination

  //update
  Future<void> updateDestination(ModelDestination modelDestination) async {
    Map<String, dynamic> updateDestinationDetails = {
      'destination name': modelDestination.destinationName,
      'district': modelDestination.districtName,
      'category': modelDestination.categoryName,
      'location url': modelDestination.location,
      'description': modelDestination.destinationDescription,
      'image urls': modelDestination.destinationImage,
    };
    await destinationReference
        .doc(modelDestination.destinationId)
        .update(updateDestinationDetails);
  }
  //update

//   //filtering

  Future<List<ModelDestination>> filterDestinations({
    List<String>? selectedDistricts,
    List<String>? selectedCategories,
  }) async {
    selectedDistricts ??= [];

    selectedCategories ??= [];

    Query query = destinationReference;

    // When no district or category is selected

    if (selectedDistricts.isEmpty && selectedCategories.isEmpty) {
      final querySnapshot = await query.get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return ModelDestination(
          destinationId: doc.id,
          destinationName: data['destination name'],
          districtName: data['district'],
          categoryName: data['category'],
          location: data['location url'],
          destinationDescription: data['description'],
          destinationImage: List<String>.from(data['image urls']),
        );
      }).toList();
    }

    // Only district selected

    else if (selectedDistricts.isNotEmpty && selectedCategories.isEmpty) {
      final querySnapshot =
          await query.where('district', whereIn: selectedDistricts).get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return ModelDestination(
          destinationId: doc.id,
          destinationName: data['destination name'],
          districtName: data['district'],
          categoryName: data['category'],
          location: data['location url'],
          destinationDescription: data['description'],
          destinationImage: List<String>.from(data['image urls']),
        );
      }).toList();
    }

    // Only category selected

    else if (selectedDistricts.isEmpty && selectedCategories.isNotEmpty) {
      final querySnapshot =
          await query.where('category', whereIn: selectedCategories).get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return ModelDestination(
          destinationId: doc.id,
          destinationName: data['destination name'],
          districtName: data['district'],
          categoryName: data['category'],
          location: data['location url'],
          destinationDescription: data['description'],
          destinationImage: List<String>.from(data['image urls']),
        );
      }).toList();
    }

    // Both district and category selected

    else {
      final querySnapshot =
          await query.where('district', whereIn: selectedDistricts).get();

      final filteredDocs = querySnapshot.docs.where((doc) {
        final data = doc.data() as Map<String, dynamic>;

        final destinationCategory = data['category'] as String?;

        return selectedCategories!.contains(destinationCategory);
      }).toList();

      return filteredDocs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return ModelDestination(
          destinationId: doc.id,
          destinationName: data['destination name'],
          districtName: data['district'],
          categoryName: data['category'],
          location: data['location url'],
          destinationDescription: data['description'],
          destinationImage: List<String>.from(data['image urls']),
        );
      }).toList();
    }
  }
  //filtering

  //random list
  Future<List<ModelDestination>> fetchRandomDestinations() async {
    Query query = destinationReference;

    // Get the total number of documents in the collection
    final QuerySnapshot snapshot = await query.get();
    final totalDocuments = snapshot.size;

    if (totalDocuments == 0) {
      // Handle the case when the collection is empty
      return [];
    }

    // Generate random indices to get six random documents
    final random = Random();
    final randomIndices = <int>{};
    while (randomIndices.length < 6) {
      randomIndices.add(random.nextInt(totalDocuments));
    }

    // Fetch the six random destinations using the generated indices
    final randomDocs =
        randomIndices.map((index) => snapshot.docs[index]).toList();

    return randomDocs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      return ModelDestination(
        destinationId: doc.id,
        destinationName: data['destination name'],
        districtName: data['district'],
        categoryName: data['category'],
        location: data['location url'],
        destinationDescription: data['description'],
        destinationImage: List<String>.from(data['image urls']),
      );
    }).toList();
  }

  Future<void> getRandomDestinations() async {
    final List<ModelDestination> randomDestinations =
        await fetchRandomDestinations();
    ramdomListNotifier.value = randomDestinations;
  }

  ///
}

getfiltered() async {
  List<ModelDestination> filteredDestinations = await DestinationRepository()
      .filterDestinations(
          selectedCategories: selectedCategories,
          selectedDistricts: selectedDistricts);

  filterNotifier.value = filteredDestinations;
}
