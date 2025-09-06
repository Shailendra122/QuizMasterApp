import 'package:flutter/material.dart';
import 'package:quizmasterapp/utils/app_sizes.dart';
import 'package:quizmasterapp/view/start_page.dart';
import 'package:quizmasterapp/widget/app_scaffold.dart';
import 'package:quizmasterapp/utils/colors.dart';

import '../utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const StartPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppScaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryGradientStart,
              AppColors.primaryGradientEnd,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outlined,
                size: AppSizes.dp(100),
                color: AppColors.getStartingIconColor(context),
              ),
              SizedBox(height: AppSizes.dp(20)),
              Text(
                AppConstants.appHeaderText,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.getHeadingTextColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSizes.dp(10)),
              Text(
                AppConstants.appSubHeaderText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.getHeadingTextColor(context),
                ),
              ),
              SizedBox(height: AppSizes.dp(20)),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.getStartingIconColor(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
