// import 'package:flutter/material.dart';
// import 'package:unloack/styles/colors.dart';
// import 'package:unloack/styles/space.dart';
// import 'package:unloack/styles/text_styles.dart';

// class TripDays extends StatelessWidget {
//   TripDays({
//     Key? key,
//     required this.numberOfCards,
//     required this.listOfDays,
//   });
//   int numberOfCards;
//   List<DateTime> listOfDays;

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     double screenWidth = screenSize.width;
//     double screenHeight = screenSize.height;
//     List<String> daysList = [];

//     // Extract date part from DateTime objects and add to daysList
//     for (DateTime day in listOfDays) {
//       String date = day.toString().split(' ')[0];
//       daysList.add(date);
//       daysList.sort();
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       // Set the desired background color
//       // floatingActionButton: FloatingActionButton.extended(
//       //     onPressed: () {},
//       //     label: Text(
//       //       'Done',
//       //       style: personalisedlistText,
//       //     )),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: GridView.builder(
//             itemCount: numberOfCards,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisSpacing: 8.0, // Set the desired spacing horizontally
//               mainAxisSpacing: 8.0, // Set the desired spacing vertically
//               crossAxisCount: 3,
//             ),
//             itemBuilder: (context, index) => Card(
//                 color: primaryBlue,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Color.fromARGB(88, 128, 184, 230),
//                             borderRadius: BorderRadius.circular(8)),
//                         width: double.infinity,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(top: 5.0, left: 5),
//                               child: Text(daysList[index]),
//                             ),
//                             verticalSpace(15),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'day ${index + 1}',
//                                   style: personalisedlistText,
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Color.fromARGB(137, 175, 228, 230),
//                             borderRadius: BorderRadius.circular(5)),
//                         width: double.infinity,
//                         child: TextButton.icon(
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.update_sharp,
//                               color: Colors.white,
//                             ),
//                             label: const Text(
//                               'Add Place',
//                               style: TextStyle(color: Colors.white),
//                             )),
//                       ),
//                     )
//                   ],
//                 )),
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.white,
//         child: Container(
//           height: screenHeight / 14,
//           width: double.infinity,
//           color: Colors.transparent,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(
//                   right: screenWidth / 35,
//                   // top: screenWidth / 35,
//                   // bottom: screenWidth / 35
//                 ),
//                 child: FloatingActionButton.extended(
//                     backgroundColor: Color.fromARGB(147, 33, 149, 243),
//                     onPressed: () {},
//                     label: Text(
//                       'Done',
//                       style: personalisedlistText,
//                     )),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
