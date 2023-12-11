import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unloack/db/firebase/firebase_crud.dart';
import 'package:unloack/favorite/favorite_functions.dart';
import 'package:unloack/favorite/favorite_icon.dart';
import 'package:unloack/screens/home_page.dart';
import 'package:unloack/styles/space.dart';
import 'package:unloack/widgets/emtypage_image.dart';
import '../../db/model/firebase_model/model_destination.dart';
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
import 'alldetails_firebase.dart';

class ListCustomFirebase extends StatelessWidget {
  // List<String> categeryList;

  // List<String> districtList;

  const ListCustomFirebase({
    Key? key,
    // required this.categeryList,
    // required this.districtList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // filterNotifier.value.isNotEmpty
    //     ? print(filterNotifier.value[0].categoryName)
    //     : print('');
    getfiltered();
    final favoriteModel = Provider.of<FavoriteModel>(context);
    favoriteModel.initFavorites(currentUser!.uid);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: const Text('Personalised list'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * .01, horizontal: screenWidth * 0.02),
        child: SafeArea(
          child: ValueListenableBuilder<List<ModelDestination>>(
              valueListenable: filterNotifier,
              builder: (context, List<ModelDestination> filterd, child) {
                return filterd.isEmpty
                    ? Center(
                        child: EmptyPage(
                        displayText: 'Selected Combinations\nNot Found !',
                        displayTextColor: primaryBlue,
                      )
                        // Image.asset('assets/images/emptypage.png'),
                        )
                    : ListView.separated(
                        separatorBuilder: (context, index) {
                          return verticalSpace(30);
                        },
                        itemCount: filterd.length,
                        itemBuilder: (context, index) {
                          var data = filterd[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullDetailsFirebase(
                                      destinationModel: data,
                                    ),
                                  ));
                            },
                            child: Container(
                                width: screenWidth,
                                height: screenHeight / 6,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            data.destinationImage[0])),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.destinationName,
                                          style: personalisedlistText,
                                        ),
                                        IconFavorite(
                                            destinationId: data.destinationId!)
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        },
                      );
              }),
        ),
      ),
    );
  }
}
