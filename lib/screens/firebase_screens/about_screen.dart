import 'package:flutter/material.dart';
import 'package:unloack/styles/colors.dart';

import '../../styles/text_styles.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
        backgroundColor: primaryBlue,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        height: screenHeight / 18,
        child: const Center(
          child: Text(
            'Version 1.0.0',
            style: subHeadingNormal,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(screenHeight / 50),
        child: ListView(
          children: const [
            Text(
                'Welcome to Unlock Kerala, the ultimate travel app that unveils the captivating beauty and rich cultural tapestry of God\'s Own Country. Kerala, located along India\'s southwestern coast, is a paradise for travelers seeking a diverse and enchanting experience.Unlock Kerala takes you on a journey through the tranquil backwaters, where traditional houseboats glide along palm-fringed canals, offering a serene escape from the bustling world. Trek the misty hills of the Western Ghats, embracing nature\'s bounty with every step.As you venture to the sandy shores of the Arabian Sea, let the cool breeze caress your face and the rhythmic waves soothe your soul.Unravel the secrets of Kerala\'s history and heritage by visiting ancient temples, majestic forts, and colonial-era buildings.Unlock Kerala empowers you to customize your journey using intuitive filters, ensuring you discover destinations aligned with your interests and preferences. Create a personalized favorite list, cherishing memories and planning future adventures.',
                style: TextStyle(
                    height: 2,
                    fontSize: 15,
                    color: Color.fromARGB(255, 135, 127, 127))),
          ],
        ),
      )),
    );
  }
}
