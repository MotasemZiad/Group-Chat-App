import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/auth/providers/auth_provider.dart';
import 'package:gsg_firebase/auth/providers/firestore_provider.dart';
import 'package:gsg_firebase/auth/ui/screens/auth_main_screen.dart';
import 'package:gsg_firebase/auth/ui/screens/reset_password_screen.dart';
import 'package:gsg_firebase/auth/ui/screens/splash_screen.dart';
import 'package:gsg_firebase/chat/ui/screens/chat_screen.dart';
import 'package:gsg_firebase/chat/ui/screens/edit_profile_screen.dart';
import 'package:gsg_firebase/chat/ui/screens/home_screen.dart';
import 'package:gsg_firebase/services/route_helper.dart';
import 'package:gsg_firebase/utils/constants.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirestoreProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: ThemeData(
          primarySwatch: colorPrimary,
          fontFamily: 'OpenSans',
        ),
        navigatorKey: RouteHelper.routeHelper.navigatorKey,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          AuthMainScreen.routeName: (context) => AuthMainScreen(),
          ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          EditProfileScreen.routeName: (context) => EditProfileScreen(),
          ChatScreen.routeName: (context) => ChatScreen(),
        },
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
