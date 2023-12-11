import 'package:flutter/material.dart';
import 'package:unloack/db/firebase/firebase_crud.dart';
import 'package:unloack/db/model/firebase_model/model_destination.dart';

class FirebaseDataDisplay extends StatelessWidget {
  const FirebaseDataDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    DestinationRepository().getAllDestinations();
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder<List<ModelDestination>>(
              valueListenable: allDestinations,
              builder: (context, List<ModelDestination> list, _) {
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final data = list[index];
                    return Column(
                      children: [
                        Text(data.destinationName),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0;
                                i < data.destinationImage.length;
                                i++)
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(data.destinationImage[i]),
                              )
                          ],
                        )
                      ],
                    );
                  },
                );
              })),
    );
  }
}
