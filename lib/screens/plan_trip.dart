// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:unloack/screens/tripplan_second_page.dart';
// import 'package:unloack/styles/colors.dart';
// import 'package:unloack/styles/space.dart';
// import 'package:unloack/styles/text_styles.dart';

// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   final _formKey = GlobalKey<FormState>();
//   DateTime? _selectedStartDay;
//   DateTime? _selectedEndDay;
//   DateTime _focusedDay = DateTime.now();
//   DateTime _firstDay = DateTime.utc(DateTime.now().year - 1, 1, 1);
//   DateTime _lastDay = DateTime.utc(DateTime.now().year + 1, 12, 31);
//   String? tripName;
//   List<DateTime> selectedDays = [];

//   @override
//   void initState() {
//     super.initState();
//     _selectedStartDay = DateTime.now();
//     _selectedEndDay = DateTime.now();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     double screenWidth = screenSize.width;
//     double screenHeight = screenSize.height;
//     // Calculate the difference between start and end dates
//     Duration difference = _selectedEndDay != null && _selectedStartDay != null
//         ? _selectedEndDay!.difference(_selectedStartDay!) + Duration(days: 1)
//         : Duration();
//     int differenceInDays = difference.inDays;
//     submitClick() {
//       final form = _formKey.currentState;
//       if (form != null && form.validate()) {
//         form.save();
//         _formKey.currentState!.reset();
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TripDays(
//               numberOfCards: differenceInDays,
//               listOfDays: selectedDays,
//             ),
//           ),
//         );
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: screenHeight / 9.5,
//         backgroundColor: primaryBlue,
//         title: const Text(
//           'Plan Your Trips Here',
//           style: mainHeadingStyle,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//           backgroundColor: Color.fromARGB(96, 4, 252, 252),
//           onPressed: () {},
//           label: Text(
//             'View Existing Plans',
//             style: personalisedlistText,
//           )),
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           children: [
//             verticalSpace(screenHeight / 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: TextFormField(
//                 decoration: const InputDecoration(
//                     hintText: 'Trip Name', border: OutlineInputBorder()),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter the trip name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   tripName = value;
//                 },
//               ),
//             ),
//             verticalSpace(screenHeight / 40),
//             const Text(
//               ' Select Departure Date and Return Date',
//               style: subHeadingStyle,
//             ),
//             verticalSpace(screenHeight / 50),
//             //calender

//             Card(
//               color: const Color.fromARGB(255, 244, 242, 242),
//               elevation: 10,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               child: TableCalendar(
//                 calendarFormat: _calendarFormat,
//                 focusedDay: _focusedDay,
//                 firstDay: _firstDay,
//                 lastDay: _lastDay,
//                 selectedDayPredicate: (day) {
//                   return isSameDay(_selectedStartDay, day) ||
//                       isSameDay(_selectedEndDay, day) ||
//                       (_selectedStartDay != null &&
//                           _selectedEndDay != null &&
//                           day.isAfter(_selectedStartDay!) &&
//                           day.isBefore(_selectedEndDay!));
//                 },
//                 onDaySelected: (selectedDay, focusedDay) {
//                   setState(() {
//                     if (_selectedStartDay == null || _selectedEndDay != null) {
//                       _selectedStartDay = selectedDay;
//                       _selectedEndDay = null;
//                     } else if (selectedDay.isAfter(_selectedStartDay!)) {
//                       _selectedEndDay = selectedDay;
//                     } else {
//                       _selectedEndDay = _selectedStartDay;
//                       _selectedStartDay = selectedDay;
//                     }
//                     _focusedDay = focusedDay;
//                     // Update the selectedDays list
//                     selectedDays =
//                         getSelectedDays(); // update the focused day when selected
//                   });
//                 },
//                 onFormatChanged: (format) {
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 },
//                 calendarStyle: const CalendarStyle(
//                   todayDecoration: BoxDecoration(
//                     color: Colors.blue,
//                     shape: BoxShape.circle,
//                   ),
//                   selectedDecoration: BoxDecoration(
//                     color: Colors.green,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//             //calender

//             verticalSpace(16),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth / 19),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Start Date: ${_selectedStartDay != null ? _selectedStartDay!.toString().split(' ')[0] : 'Select a date'}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   verticalSpace(8),
//                   Text(
//                     'End Date: ${_selectedEndDay != null ? _selectedEndDay!.toString().split(' ')[0] : 'Select a date'}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//             verticalSpace(screenHeight / 50),
//             Container(
//               width: 200.0, // Specify the desired width
//               child: FloatingActionButton(
//                 onPressed: () {
//                   submitClick();
//                   print(selectedDays);
//                   print(differenceInDays);
//                 },
//                 child: Icon(
//                   Icons.arrow_circle_right_outlined,
//                   size: 50,
//                 ),
//                 backgroundColor: primaryBlue,
//                 elevation: 10,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<DateTime> getSelectedDays() {
//     List<DateTime> days = [];

//     if (_selectedStartDay != null) {
//       final startDate = DateTime(
//         _selectedStartDay!.year,
//         _selectedStartDay!.month,
//         _selectedStartDay!.day,
//       );
//       days.add(startDate);
//     }
//     if (_selectedEndDay != null) {
//       final endDate = DateTime(
//         _selectedEndDay!.year,
//         _selectedEndDay!.month,
//         _selectedEndDay!.day,
//       );
//       days.add(endDate);
//     }

//     if (_selectedStartDay != null && _selectedEndDay != null) {
//       DateTime nextDay = _selectedStartDay!.add(const Duration(days: 1));
//       while (nextDay.isBefore(_selectedEndDay!)) {
//         final nextDate = DateTime(
//           nextDay.year,
//           nextDay.month,
//           nextDay.day,
//         );
//         days.add(nextDate);
//         nextDay = nextDay.add(const Duration(days: 1));
//       }
//     }

//     return days;
//   }
// }
