import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_theme.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/providers/auth_provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/providers/theme_provider.dart';
import 'package:todo/screens/auth/log_in_screen.dart';
import 'package:todo/screens/auth/sign_up_screen.dart';
import 'package:todo/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TasksProvider()),
      ChangeNotifierProvider(create: (context) => TodoAuthProvider()),
      ChangeNotifierProvider(create: (context) => ThemeProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).appThemeMode,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        LogInScreen.routeName: (context) => const LogInScreen(),
      },
      initialRoute: FirebaseAuth.instance.currentUser?.uid == null
          ? SignUpScreen.routeName
          : HomeScreen.routeName,
    );
  }
}
