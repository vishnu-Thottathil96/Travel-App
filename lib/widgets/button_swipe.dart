// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:unloack/db/firebase/firebase_crud.dart';
import '../screens/firebase_screens/firebase_customised_screen.dart';

class ButtonAnimated extends StatefulWidget {
  const ButtonAnimated({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ButtonAnimatedState createState() => _ButtonAnimatedState();
}

class _ButtonAnimatedState extends State<ButtonAnimated> {
  bool isButtonVisible = true;
  bool waiting = false;

  @override
  Widget build(BuildContext context) {
    return waiting
        ? const Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(child: LinearProgressIndicator()),
          )
        : isButtonVisible
            ? Dismissible(
                key: const Key('button'),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) async {
                  if (direction == DismissDirection.startToEnd ||
                      direction == DismissDirection.endToStart) {
                    setState(() {
                      isButtonVisible = false;
                      waiting = true;
                    });

                    await getfiltered();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const ListCustomFirebase();
                      }),
                    ).then((_) {
                      setState(() {
                        isButtonVisible = true;
                        waiting = false;
                      });
                    });
                  }
                },
                background: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                      child: Text('Escape to New Destinations, Adventurer!')),
                ),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isButtonVisible = false;
                    });

                    await getfiltered();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const ListCustomFirebase();
                      }),
                    ).then((_) {
                      setState(() {
                        isButtonVisible = true;
                      });
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.flight_takeoff),
                      label:
                          const Text('Swipe >> to view your personalised list'),
                    ),
                  ),
                ),
              )
            : Container();
  }
}
