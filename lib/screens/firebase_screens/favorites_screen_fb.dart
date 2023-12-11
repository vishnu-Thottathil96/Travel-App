import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unloack/favorite/favorite_functions.dart';
import 'package:unloack/styles/colors.dart';
import 'package:unloack/styles/space.dart';
import 'package:unloack/styles/text_styles.dart';
import 'package:unloack/widgets/emtypage_image.dart';
import '../../db/model/firebase_model/model_destination.dart';
import '../../favorite/favorite_icon.dart';
import '../home_page.dart';
import 'alldetails_firebase.dart';

class FavoriteListFB extends StatefulWidget {
  const FavoriteListFB({super.key});

  @override
  State<FavoriteListFB> createState() => _FavoriteListFBState();
}

class _FavoriteListFBState extends State<FavoriteListFB> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    FavoriteModel().favoritesListenable;
    _loadFavorites();
  }

  void _loadFavorites() async {
    final favoriteModel = Provider.of<FavoriteModel>(context, listen: false);
    await favoriteModel.initFavorites(currentUser!.uid);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);

    favoriteModel.initFavorites(currentUser!.uid);
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: screenHeight / 15,
        backgroundColor: primaryBlue,
        title: const Text('Favorites'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * .01, horizontal: screenWidth * 0.02),
        child: SafeArea(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ValueListenableBuilder<List<ModelDestination>>(
                    valueListenable: favoriteModel.favoritesListenable,
                    builder: (context, List<ModelDestination> list, child) {
                      return list.isEmpty
                          ? EmptyPage(
                              displayText: 'Favorites List Empty',
                              displayTextColor: primaryBlue)
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                var data = list[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FullDetailsFirebase(
                                                  destinationModel: data,
                                                )));
                                  },
                                  child: Container(
                                    width: screenWidth,
                                    height: screenHeight / 6,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                data.destinationImage[0]),
                                            fit: BoxFit.cover),
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
                                                destinationId:
                                                    data.destinationId!)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return verticalSpace(30);
                              },
                              itemCount: list.length);
                    })),
      ),
    );
  }
}
