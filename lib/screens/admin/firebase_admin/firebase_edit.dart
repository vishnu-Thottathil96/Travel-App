import 'package:flutter/material.dart';
import 'package:unloack/db/firebase/firebase_crud.dart';
import 'package:unloack/db/model/firebase_model/model_destination.dart';
import 'package:unloack/styles/space.dart';

// ignore: must_be_immutable
class FirebaseEditPage extends StatefulWidget {
  FirebaseEditPage({Key? key, required this.data}) : super(key: key);
  ModelDestination data;

  @override
  State<FirebaseEditPage> createState() => _FirebaseEditPage();
}

class _FirebaseEditPage extends State<FirebaseEditPage> {
  final _formKey = GlobalKey<FormState>();

  late String _placeName;

  late String _description;

  late String _locationInfo;

  @override
  Widget build(BuildContext context) {
    Future<void> submitClick(ModelDestination data) async {
      final name = _placeName;
      final description = _description;
      final location = _locationInfo;
      if (name.isEmpty || description.isEmpty || location.isEmpty) {
        return;
      }
      data.destinationName = name;
      data.destinationDescription = description;
      data.location = location;
      DestinationRepository().updateDestination(data);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit data from firebase',
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

                        verticalSpace(20),
                        //name field
                        TextFormField(
                          initialValue: widget.data.destinationName,
                          decoration: const InputDecoration(
                              hintText: 'Name of place',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 10)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter place name';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _placeName = value!;
                          },
                        ),
                        //name field end

                        verticalSpace(20),

                        //description field
                        TextFormField(
                          initialValue: widget.data.destinationDescription,
                          decoration: const InputDecoration(
                              hintText: 'Description',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 10)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Add description';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _description = value!;
                          },
                        ),
                        //description field end

                        const SizedBox(
                          height: 20,
                        ),

                        // location field
                        TextFormField(
                          initialValue: widget.data.location,
                          decoration: const InputDecoration(
                              hintText: 'Location info',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 10)))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Add location info';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _locationInfo = value!;
                          },
                        ),
                        //location field end
                        const SizedBox(
                          height: 20,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        verticalSpace(20),

                        //submit button
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(400, 70),
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0, vertical: 20.0),
                                backgroundColor:
                                    const Color.fromARGB(255, 162, 210, 223)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                submitClick(widget.data);
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text(
                              'Update',
                              style: TextStyle(fontSize: 20),
                            )),
                        //submit button end
                      ],
                    )))
          ],
        ),
      )),
    );
  }
}
