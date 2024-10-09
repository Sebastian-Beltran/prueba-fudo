import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prueba_fudo/core/constants/palette.dart';
import 'package:prueba_fudo/presentation/widgets/login_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.primary,
      body: Padding(
        padding: const EdgeInsets.only(top: 180),
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/img/login.svg',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Palette.white,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              height: size.height * 0.52,
              child: const LoginWidgets(),
            ),
          ],
        ),
      ),
    );
  }
}
