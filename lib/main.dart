import 'package:asyltas_app/core/services/local_storage.dart';
import 'package:asyltas_app/features/main/presentation/pages/home_page.dart';
import 'package:asyltas_app/firebase_options.dart';
import 'package:asyltas_app/provider/cart_provider.dart';
import 'package:asyltas_app/provider/di_utils.dart';
import 'package:asyltas_app/provider/favorites_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((_) {
    runApp(const MainApp());
  });
}

class MyScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child; // Removes the scrollbar
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: LocalStorage()),
        ChangeNotifierProvider(
          create: (context) => CartProvider(
            localStorage: provideOnce(context),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(),
        ),
      ],
      child: MaterialApp(
        scrollBehavior: MyScrollBehavior(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomePage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
