import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quizmasterapp/services/service_locator.dart';
import 'package:quizmasterapp/store/quiz_store.dart';
import 'package:quizmasterapp/utils/app_constants.dart';
import 'package:quizmasterapp/utils/app_sizes.dart';
import 'package:quizmasterapp/utils/app_theme.dart';
import 'package:quizmasterapp/widget/splash_screen.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final store = getIt<QuizStore>();
    return Observer(builder: (context) {
      return MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: store.themeMode,
        home: const HomeScreen(),
      );
    });
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);
    return Scaffold(
      body: SafeArea(
        child: SplashScreen(),
      ),
    );
  }
}
