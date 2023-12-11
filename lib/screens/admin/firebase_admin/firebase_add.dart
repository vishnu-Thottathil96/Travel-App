import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unloack/lists/category.dart';
import 'package:unloack/screens/admin/firebase_admin/firebase_edit_delete.dart';
import 'package:unloack/screens/admin/firebase_admin/test_display_firebase.dart';
import 'package:unloack/styles/colors.dart';
import 'package:unloack/styles/space.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../db/firebase/firebase_crud.dart';
import '../../../lists/district.dart';

class FirebaseAdd extends StatefulWidget {
  const FirebaseAdd({Key? key}) : super(key: key);

  @override
  State<FirebaseAdd> createState() => _FirebaseAdd();
}

class _FirebaseAdd extends State<FirebaseAdd> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? districtSelectedValue;
  String? categorySelectedValue;

  final picker = ImagePicker();

  List<String> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    /////submit
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: const Text(
          'Firebase Add',
          style: TextStyle(color: Colors.red),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(20),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      verticalSpace(20),
                      // district dropdown
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Select district',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        value: districtSelectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            districtSelectedValue = newValue;
                          });
                        },
                        items: districts.map((district) {
                          return DropdownMenuItem<String>(
                            value: district,
                            child: Text(district),
                          );
                        }).toList(),
                      ),

                      //district dropdown
                      verticalSpace(20),

                      //category dropdown
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'Select category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        value: categorySelectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            categorySelectedValue = newValue;
                          });
                        },
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                      ),

                      //category dropdown
                      verticalSpace(20),
                      //name field
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: 'Name of place',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(10, 10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter place name';
                          }
                          return null;
                        },
                      ),
                      //name field end

                      verticalSpace(20),

                      //description field
                      TextFormField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(10, 10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Add description';
                          }
                          return null;
                        },
                      ),
                      //description field end

                      const SizedBox(
                        height: 20,
                      ),

                      // location field
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Location info',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(10, 10)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Add location info';
                          }
                          return null;
                        },
                        controller: locationController,
                      ),
                      //location field end
                      const SizedBox(
                        height: 20,
                      ),

                      //upload photo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              await pickImager(nameController.text);
                            },
                            icon: const Icon(Icons.cloud_upload_outlined),
                            label: const Text(
                              'Upload Photo',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      //upload photo end

                      //submit button
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(400, 70),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20.0),
                          backgroundColor:
                              const Color.fromARGB(255, 162, 210, 223),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            submitClick();
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text(
                          'Save',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      //submit button end

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FirebaseDataDisplay(),
                                ),
                              );
                            },
                            child: const Text('List of destinations'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Edit button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FirebaseEditDelete(),
                    ),
                  );
                },
                child: const Text('Edit & delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> uploadImageToFirebase(
      {required String destinationName, required String imagePath}) async {
    String fileName = imagePath.split('/').last;
    String folderName = 'destinationImages';
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child(folderName)
        .child(destinationName)
        .child(fileName);
    firebase_storage.UploadTask uploadTask = ref.putFile(File(imagePath));
    firebase_storage.TaskSnapshot storageTaskSnapshot =
        await uploadTask.whenComplete(() => null);
    String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> pickImager(String destinationName) async {
    List<String>? imagePaths = await getImages(context);
    if (imagePaths != null && imagePaths.isNotEmpty) {
      for (String imagePath in imagePaths) {
        String imageUrl = await uploadImageToFirebase(
          destinationName: destinationName,
          imagePath: imagePath,
        );
        setState(() {
          imageUrls.add(imageUrl);
        });
      }
    }
  }

  Future<List<String>?> getImages(BuildContext context) async {
    final pickedFiles = await picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('images added')));

    // ignore: unnecessary_null_comparison
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      return pickedFiles.map((file) => file.path).toList();
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image is selected')),
      );
      return null;
    }
  }

  void submitClick() async {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text;
      final description = descriptionController.text;
      final location = locationController.text;

      if (name.isEmpty ||
          description.isEmpty ||
          location.isEmpty ||
          imageUrls.isEmpty ||
          categorySelectedValue == null ||
          districtSelectedValue == null) {
        return;
      }

      final destinationRepository = DestinationRepository();
      await destinationRepository.addDestinationToFirebase(
        destinationName: name,
        districtName: districtSelectedValue!,
        categoryName: categorySelectedValue!,
        location: location,
        destinationDescription: description,
        destinationImageUrl: imageUrls,
      );

      // Clear the form fields
      setState(() {
        nameController.text = '';
        descriptionController.text = '';
        locationController.text = '';
        districtSelectedValue = null;
        categorySelectedValue = null;
        imageUrls.clear();
      });

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Destination added successfully')),
      );
    }
  }
}
