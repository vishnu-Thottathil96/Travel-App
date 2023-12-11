import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:unloack/db/model/firebase_model/model_destination.dart';
import 'package:unloack/styles/space.dart';
import 'package:unloack/styles/text_styles.dart';
import '../../favorite/favorite_icon.dart';
import '../../widgets/location_button.dart';

// ignore: must_be_immutable
class FullDetailsFirebase extends StatelessWidget {
  FullDetailsFirebase({
    super.key,
    required this.destinationModel,
  });

  ModelDestination destinationModel;
  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> currentPageViewIndexNotifier = ValueNotifier<int>(0);
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          return true;
        },
        child: Padding(
          padding: EdgeInsets.all(screenWidth / 35),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    height: screenHeight / 2.1,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        PageView.builder(
                          onPageChanged: (value) {
                            currentPageViewIndexNotifier.value = value;
                          },
                          itemCount: destinationModel.destinationImage.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      destinationModel.destinationImage[index],
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                            // Container(
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10),
                            //       image: DecorationImage(
                            //           fit: BoxFit.cover,
                            //           image: CachedNetworkImageProvider(
                            //             destinationModel
                            //                 .destinationImage[index],
                            //           ))),
                            // );
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ValueListenableBuilder<int>(
                              valueListenable: currentPageViewIndexNotifier,
                              builder: (context, value, child) {
                                return DotsIndicator(
                                  dotsCount:
                                      destinationModel.destinationImage.length,
                                  position: value,
                                  decorator: const DotsDecorator(
                                    color: Colors.grey,
                                    activeColor: Colors.blue,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(screenWidth / 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //     //back
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color.fromARGB(32, 0, 0, 0),
                                ),
                                width: 45,
                                height: 45,
                                child: IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              //     //back
                              //fav
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color.fromARGB(32, 0, 0, 0),
                                ),
                                width: 45,
                                height: 45,
                                child: IconFavorite(
                                    destinationId:
                                        destinationModel.destinationId!),
                              )
                              //fav
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //container

                  //image

                  verticalSpace(screenWidth / 30),
                  //destination name
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(destinationModel.destinationName,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600)),
                  ),
                  //destination name

                  //district name and location info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth / 35),
                        child: Text(
                          destinationModel.districtName,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 70, 69, 69)),
                        ),
                      ),
                      //location button

                      LocationButton(locationLink: destinationModel.location),
                      //location button
                    ],
                  ),
                  //district name and location info

                  verticalSpace(screenWidth / 40),
                  Container(
                    width: screenWidth,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: mainHeadingStyle,
                            ),
                          ],
                        ),
                        verticalSpace(screenWidth / 40),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            destinationModel.destinationDescription,
                            style: subHeadingNormal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
