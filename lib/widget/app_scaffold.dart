import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomButton;

  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: body,
      ),
      bottomNavigationBar: bottomButton != null
          ? SafeArea(
              minimum: const EdgeInsets.all(8),
              child: Container(
                color: Colors.transparent,
                child: bottomButton,
              ),
            )
          : null,
    );
  }
}
