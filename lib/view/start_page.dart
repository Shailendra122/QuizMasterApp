import 'package:flutter/material.dart';
import 'package:quizmasterapp/utils/app_constants.dart';
import 'package:quizmasterapp/utils/app_sizes.dart';
import 'package:quizmasterapp/view/start_quiz_page.dart';
import 'package:quizmasterapp/utils/colors.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool _animateIn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animateIn = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final content = Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.dp(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _animateIn ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              child: Transform.scale(
                scale: _animateIn ? 1.0 : 0.5,
                child: Container(
                  width: AppSizes.dp(150),
                  height: AppSizes.dp(150),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Semantics(
                      label: 'Quiz icon',
                      child: Icon(
                        Icons.article_outlined,
                        size: AppSizes.dp(100),
                        color: AppColors.getIconColor(context),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSizes.dp(20)),
            Text(
              AppConstants.quizText,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: AppColors.getHeadingTextColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSizes.dp(20)),
            Text(
              AppConstants.quizText2,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.getBodyTextColor(context),
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      decoration: isDark
          ? const BoxDecoration(gradient: AppColors.primaryGradient)
          : null,
      child: Scaffold(
        backgroundColor:
            isDark ? Colors.transparent : theme.appBarTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor:
              isDark ? Colors.transparent : theme.appBarTheme.backgroundColor,
          elevation: isDark ? 0 : 4,
          title: Text(
            AppConstants.appName,
            style: theme.appBarTheme.titleTextStyle,
          ),
          iconTheme: theme.appBarTheme.iconTheme,
        ),
        body: content,
        bottomNavigationBar: SafeArea(
          bottom: true,
          child: Padding(
            padding: EdgeInsets.all(AppSizes.dp(8)),
            child: SizedBox(
              width: double.infinity,
              height: AppSizes.dp(55),
              child: isDark
                  ? Ink(
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSizes.dp(30))),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StartQuizPage(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(AppSizes.dp(30)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSizes.dp(15),
                            horizontal: AppSizes.dp(30),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppConstants.next,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StartQuizPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.getButtonColor(context),
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding:
                            EdgeInsets.symmetric(vertical: AppSizes.dp(15)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.dp(30)),
                        ),
                        textStyle: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(AppConstants.next),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
