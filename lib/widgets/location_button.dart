import 'package:flutter/material.dart';
import 'package:unloack/styles/colors.dart';
import 'package:unloack/styles/space.dart';
import '../functions/launchmap.dart';

class LocationButton extends StatelessWidget {
  final String locationLink;

  const LocationButton({Key? key, required this.locationLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              elevation: 100,
              backgroundColor: Colors.white,
              duration: const Duration(minutes: 1),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Where\'s your venue?',
                    style: TextStyle(
                        color: Color.fromARGB(255, 84, 80, 80), fontSize: 20),
                  ),
                  verticalSpace(screenHeight / 90),
                  const Text(
                    'Use the Google maps to find the most convenient route to your venue',
                    style: TextStyle(
                        color: Color.fromARGB(255, 118, 115, 115),
                        fontSize: 15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(screenWidth / 2.5, screenHeight / 30),
                              side: BorderSide(color: primaryBlue)),
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: primaryBlue, fontSize: 18),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(screenWidth / 2.5, screenHeight / 30),
                              backgroundColor: primaryBlue),
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            launchGoogleMaps(locationLink);
                          },
                          child: const Text('Open Maps',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                    ],
                  )
                ],
              )));
          // launchGoogleMaps(locationLink);
        },
        child: Padding(
          padding: EdgeInsets.only(right: screenWidth / 100),
          child: SizedBox(
            height: screenHeight / 25,
            width: screenHeight / 25,
            child: const Image(
              image: AssetImage('assets/images/googlemaps.png'),
            ),
          ),
        ));
  }
}
