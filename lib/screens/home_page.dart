import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:unloack/functions/signout.dart';
import 'package:unloack/screens/firebase_screens/about_screen.dart';
import 'package:unloack/styles/colors.dart';
import 'package:unloack/styles/space.dart';
import 'package:unloack/styles/text_styles.dart';
import 'package:unloack/widgets/alert.dart';
import 'package:unloack/widgets/districts_checkbox.dart';
import '../db/firebase/firebase_crud.dart';
import '../db/functions/firebase_functions.dart/auth.dart';
import '../widgets/button_swipe.dart';
import '../widgets/category_card.dart';
import '../widgets/trunkated_text.dart';
import 'firebase_screens/all_destinations_firebase.dart';
import 'firebase_screens/alldetails_firebase.dart';
import 'firebase_screens/favorites_screen_fb.dart';

Auth auth = Auth();
User? currentUser = auth.getCurrentUser();

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final CollectionReference userReference =
      FirebaseFirestore.instance.collection('users');
  String name = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double screenHeight = screenSize.height;
    ValueNotifier<int> currentCarouselIndexNotifier = ValueNotifier<int>(0);

    String? userEmail = currentUser!.email;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(245, 255, 255, 255),
        child: ListView(
          children: [
            StreamBuilder(
                stream: userReference.doc(currentUser!.uid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.exists) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    name = data['name'];

                    return UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 116, 196, 220)),
                      accountName: DateTime.now().hour < 12
                          ? TruncatedText('Good Morning $name', subHeadingStyle)
                          : DateTime.now().hour >= 12 &&
                                  DateTime.now().hour < 16
                              ? TruncatedText(
                                  'Good Afternoon $name', subHeadingStyle)
                              : TruncatedText(
                                  'Good Evening $name', subHeadingStyle),
                      accountEmail: Text(userEmail ?? 'Empty data'),
                    );
                  }
                  return const Text('');
                }),
            //name

            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(
                'Edit name',
                style: subHeadingNormal,
              ),
              onTap: () {
                updateUserName(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text(
                'About',
                style: subHeadingNormal,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const About(),
                    ));
              },
            ),

            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertBox(
                      firstButtonIconData: Icons.cancel_outlined,
                      firstButtonColor: Colors.black,
                      firstButtonIconColor: Colors.red,
                      firstButtonOnPressed: () => Navigator.pop(context),
                      firstButtonText: 'Cancel',
                      secondButtonIconData: Icons.check_circle_outlined,
                      secondButtonOnPressed: () => SystemNavigator.pop(),
                      secondButtonIconColor: Colors.green,
                      secondButtonColor: Colors.black,
                      secondButtonText: 'Exit',
                      message: 'Are you sure you want to exit?',
                      title: 'Confirm'),
                );
                // SystemNavigator.pop();
              },
              leading: const Icon(Icons.close),
              title: const Text(
                'Close App',
                style: subHeadingNormal,
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertBox(
                      firstButtonIconData: Icons.cancel_outlined,
                      firstButtonColor: Colors.black,
                      firstButtonIconColor: Colors.red,
                      firstButtonOnPressed: () => Navigator.pop(context),
                      firstButtonText: 'Cancel',
                      secondButtonIconData: Icons.check_circle_outlined,
                      secondButtonOnPressed: () => signOut(context),
                      secondButtonIconColor: Colors.green,
                      secondButtonColor: Colors.black,
                      secondButtonText: 'Exit',
                      message: 'Are you sure you want to logout?',
                      title: 'Confirm'),
                );
              },
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: subHeadingNormal,
              ),
            ),
          ],
        ),
      ),

      //drawer

      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                verticalSpace(3),
                // First row slogan and admin icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        Text(
                          'Unlock Kerala ',
                          style:
                              //TextStyle(color: Colors.white, fontSize: 25)
                              mainHeadingStyle,
                        ),
                        Text(
                          '  It\'s Time To Free Yourself',
                          style: subHeadingNormal,
                        ),
                      ],
                    ),

                    //icon on top rignt
                    Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(
                            Icons.dehaze_sharp,
                            size: 40,
                            color: Color.fromARGB(255, 116, 196, 220),
                          ),
                        );
                      },
                    )

                    //icon on top rignt
                  ],
                ),
                verticalSpace(6),

                // Sidewise scrollable containers of popular
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.8,
                  width: double.infinity,
                  child: Stack(children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height / 3.8,
                        viewportFraction: 1,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        onPageChanged: (index, reason) {
                          currentCarouselIndexNotifier.value = index;
                        },
                      ),
                      // items: containerIndexes.map((index) {
                      items: ramdomListNotifier.value.map((destination) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullDetailsFirebase(
                                      destinationModel: destination),
                                ));
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: destination.destinationImage[0],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color.fromARGB(
                                          255, 182, 179, 179),
                                      // You can set a custom color here for the error placeholder
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, left: 5),
                                  child: Text(
                                    destination.destinationName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: const Offset(1, 1),
                                          blurRadius: 3,
                                        ),
                                      ],
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 0,
                      right: 0,
                      child: ValueListenableBuilder<int>(
                        valueListenable: currentCarouselIndexNotifier,
                        builder: (context, value, child) {
                          return DotsIndicator(
                            dotsCount: ramdomListNotifier.value.length,
                            position: currentCarouselIndexNotifier.value,
                          );
                        },
                      ),
                    ),
                  ]),
                ),

                //upcoming trips and favorites
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AllDestinationsFromFB(),
                              ));
                        },
                        icon: Icon(
                          Icons.explore_outlined,
                          color: primaryBlue,
                        ),
                        label: const Text('Explore All')),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                // builder: (context) => FavoritesPage(),
                                builder: (context) => const FavoriteListFB(),
                              ));
                        },
                        icon: Icon(
                          Icons.favorite_outline_rounded,
                          color: primaryBlue,
                        ),
                        label: const Text(
                          'Favorites',
                        ))
                  ],
                ),

                const Divider(
                  thickness: 2,
                ),
                //upcoming trips and favorites

                const Text(
                  'Customise your jurney here',
                  style: subHeadingStyle,
                ),
                verticalSpace(screenHeight / 70),
                //dropdown
                const DropdownWithCheckboxes(),
                //dropdown
                verticalSpace(screenHeight / 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Select Categoris',
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(0, 0),
                            blurRadius: 3,
                          ),
                        ],
                        fontSize: 17,
                        color: const Color.fromARGB(255, 95, 94, 94),
                      ),
                    ),
                  ],
                ),
                verticalSpace(screenHeight / 70),
                //categories section
                const CategoryCard(),
                //categories section
                verticalSpace(screenHeight / 80),

                const ButtonAnimated(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateUserName(BuildContext context) {
    final path = userReference.doc(currentUser!.uid);
    final editNameController = TextEditingController(text: name);
    final editNameKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Name'),
          actions: [
            Form(
                key: editNameKey,
                child: TextFormField(
                  controller: editNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'name is required';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'edit name'),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    if (editNameKey.currentState!.validate()) {
                      String updateName = editNameController.text;
                      path.update({'name': updateName});
                      Navigator.pop(context);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
