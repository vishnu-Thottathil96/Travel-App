import 'package:flutter/material.dart';
import 'package:unloack/db/firebase/firebase_crud.dart';
import 'package:unloack/db/model/firebase_model/model_destination.dart';
import 'package:unloack/screens/firebase_screens/alldetails_firebase.dart';
import 'package:unloack/styles/colors.dart';

import '../../../functions/confirm_clear.dart';
import '../../../widgets/emtypage_image.dart';
import 'firebase_edit.dart';

class FirebaseEditDelete extends StatefulWidget {
  const FirebaseEditDelete({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FirebaseEditDeleteState createState() => _FirebaseEditDeleteState();
}

class _FirebaseEditDeleteState extends State<FirebaseEditDelete> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<ModelDestination> filteredList = [];

  @override
  void initState() {
    super.initState();
    DestinationRepository().getAllDestinations();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    double screenWidth = screensize.width;
    double screenHeight = screensize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: screenHeight / 13,
        shadowColor: Colors.white,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        title: SizedBox(
          height: screenHeight / 18,
          child: TextFormField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            onChanged: (value) {
              setState(
                  () {}); // Trigger a rebuild when the search query changes
            },
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth / 25),
        child: SafeArea(
          child: ValueListenableBuilder<List<ModelDestination>>(
            valueListenable: allDestinations,
            builder: (context, List<ModelDestination> list, _) {
              // If the search query is empty, show the entire list
              if (_searchController.text.isEmpty) {
                filteredList = list;
              } else {
                // Otherwise, filter the list based on the search query
                filteredList = list.where((destination) {
                  return destination.destinationName
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase());
                }).toList();
              }

              return filteredList.isEmpty
                  ? EmptyPage(
                      displayText: 'Not Fount !',
                      displayTextColor: primaryBlue,
                    )
                  : ListView.separated(
                      itemCount: filteredList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        thickness: 3.5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final data = filteredList[index];
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullDetailsFirebase(
                                      destinationModel: data),
                                ));
                          },
                          leading: CircleAvatar(
                              backgroundImage:
                                  // FileImage(File(data.destinationImage[0])),
                                  NetworkImage(data.destinationImage[0])),
                          title: Text(data.destinationName),
                          subtitle: Text('District: ${data.districtName}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showConfirmationDialog(context, () {
                                      DestinationRepository()
                                          .deleteDestinationFromFirebase(
                                              data.destinationId!);
                                    });
                                    // allDestinations.notifyListeners();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.deepOrangeAccent,
                                  )),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit_square,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FirebaseEditPage(
                                          data: data,
                                        ),
                                      ));
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
