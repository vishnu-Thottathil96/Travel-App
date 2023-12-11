// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:unloack/db/model/model_destination/destination_model.dart';
// import 'package:unloack/widgets/category_card.dart';
// import 'package:unloack/widgets/districts_checkbox.dart';

// import '../model/favorite_box.dart';

// ValueNotifier<List<DestinationModel>> destinationNotifier = ValueNotifier([]);
// void addDestination(DestinationModel destinationModel) async {
//   final destinationDB = await Hive.openBox<DestinationModel>('destinations');
//   await destinationDB.add(destinationModel);
//   getAllDestination();
// }

// void getAllDestination() async {
//   final destinationDB = await Hive.openBox<DestinationModel>('destinations');
//   destinationNotifier.value.clear();
//   destinationNotifier.value.addAll(destinationDB.values);
//   destinationNotifier.notifyListeners();
// }

// void deleteDestination(DestinationModel destinationModel) async {
//   final destinationDB = await Hive.openBox<DestinationModel>('destinations');
//   destinationModel.delete();
//   getAllDestination();
// }

// Future<void> editDestination({
//   required DestinationModel updatedDestination,
//   required String name,
//   required String description,
//   required String location,
//   required String howtoreach,
// }) async {
//   final destinationDB = await Hive.openBox<DestinationModel>('destinations');
//   updatedDestination.destinationName = name;
//   updatedDestination.destinationDescription = description;
//   updatedDestination.location = location;
//   updatedDestination.howToGet = howtoreach;
//   updatedDestination.save();
//   getAllDestination();
// }

// void deleteAllData() async {
//   final destinationDB = await Hive.openBox<DestinationModel>('destinations');
//   destinationDB.clear();
// }

// ValueNotifier<List<DestinationModel>> favoriteDestinationNotifier =
//     ValueNotifier([]);

// void addToFavorites(DestinationModel destination) {
//   destination.isfav = true;
//   destination.save();
//   getAllFavorites();
// }

// void removeFromFavorites(DestinationModel destination) {
//   destination.isfav = false;
//   destination.save();
//   getAllFavorites();
// }

// getAllFavorites() async {
//   List<DestinationModel> allFav = await getFavorites();
//   favoriteDestinationNotifier.value.clear();
//   favoriteDestinationNotifier.value.addAll(allFav);
//   favoriteDestinationNotifier.notifyListeners();
// }

// getFavorites() async {
//   final destinationDB = await Hive.openBox<DestinationModel>('destinations');
//   return destinationDB.values
//       .where((destination) => destination.isfav == true)
//       .toList();
// }

// ValueNotifier<List<DestinationModel>> filterdestinationNotifier =
//     ValueNotifier([]);

// void finalizedFiltered() async {
//   List<DestinationModel> filtered =
//       await filterDestinations(selectedDistricts, selectedCategories);
//   filterdestinationNotifier.value = filtered;
// }

// Future<List<DestinationModel>> filterDestinations(
//     List selectedDistricts, List selectedCategories) async {
//   final destinationDB = await Hive.openBox<DestinationModel>('destinations');
//   if (selectedDistricts.isEmpty && selectedCategories.isEmpty) {
//     return destinationDB.values.toList();
//   } else if (selectedDistricts.isNotEmpty && selectedCategories.isEmpty) {
//     return destinationDB.values
//         .where((destination) =>
//             selectedDistricts.contains(destination.districtName))
//         .toList();
//   } else if (selectedDistricts.isEmpty && selectedCategories.isNotEmpty) {
//     return destinationDB.values
//         .where((destination) =>
//             selectedCategories.contains(destination.categoryName))
//         .toList();
//   } else {
//     return destinationDB.values
//         .where((destination) =>
//             selectedDistricts.contains(destination.districtName) &&
//             selectedCategories.contains(destination.categoryName))
//         .toList();
//   }
// }
