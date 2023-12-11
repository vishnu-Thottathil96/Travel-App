import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unloack/db/firebase/firebase_crud.dart';
import 'package:unloack/db/model/firebase_model/model_destination.dart';
import 'package:unloack/styles/colors.dart';
import '../../widgets/emtypage_image.dart';
import '../../widgets/trunkated_text.dart';
import 'alldetails_firebase.dart';

class AllDestinationsFromFB extends StatefulWidget {
  const AllDestinationsFromFB({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllDestinationsFromFBState createState() => _AllDestinationsFromFBState();
}

class _AllDestinationsFromFBState extends State<AllDestinationsFromFB> {
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
        elevation: 0,
        toolbarHeight: screenHeight / 13,
        shadowColor: Colors.white,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(
            height: screenHeight / 16,
            child: TextFormField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: (value) {
                setState(() {
                  // Trigger a rebuild when the search query changes
                });
              },
              decoration: const InputDecoration(
                filled: true,
                fillColor:
                    Color.fromARGB(53, 151, 150, 150), // Background color
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.black, // Icon color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(
                      color: Colors.white), // Border color for unfocused state
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(
                      color: Colors.white), // Border color for focused state
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth / 35),
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
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: screenWidth / 20,
                        mainAxisSpacing: screenHeight / 45,
                      ),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final data = filteredList[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullDetailsFirebase(
                                  destinationModel: data,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  data.destinationImage[0],
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: screenWidth / 45),
                                    child: TruncatedText(
                                      data.destinationName,
                                      TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            offset: const Offset(1, 1),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: screenWidth / 45),
                                  child: TruncatedText(
                                    data.districtName,
                                    TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: const Offset(1, 1),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
