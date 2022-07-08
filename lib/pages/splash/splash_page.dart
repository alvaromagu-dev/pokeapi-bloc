import 'package:check_install/routes/paths.dart';
import 'package:flutter/material.dart';
import 'package:check_install/widgets/splash_screen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      navigateAfterFuture: () async {
        await Future.delayed(const Duration(seconds: 10,),);
        return login;
      },
      logo: Image.network(
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Twitch_logo_2019.svg/2560px-Twitch_logo_2019.svg.png'
      ),
      showLoading: true,
    );
  }
}
