import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unloack/favorite/favorite_functions.dart';
import 'package:unloack/screens/splash_screen.dart';
import 'firebase_options.dart';

//START shared pref
const saveKeyName = 'userLogedIn';
//END

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteModel = FavoriteModel();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: favoriteModel),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Unlock Kerala',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : snapshot.hasData
                        ? const Splash(logedin: true)
                        : const Splash(logedin: false)),
      ),
    );
  }
}
