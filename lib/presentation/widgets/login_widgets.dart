import 'package:flutter/material.dart';
import 'package:prueba_fudo/core/constants/colors.dart';
import 'package:prueba_fudo/presentation/widgets/custom_button.dart';
import 'package:prueba_fudo/presentation/widgets/custom_text_form_field.dart';

class LoginWidgets extends StatelessWidget {
  const LoginWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          'Login',
          style: TextStyle(
            color: Palette.primary,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 30),
        const CustomTextFormField(
          labelText: 'User',
        ),
        const SizedBox(height: 30),
        const CustomTextFormField(
          labelText: 'Password',
        ),
        const SizedBox(height: 60),
        CustomButton(
          onPressed: () {
            Navigator.pushNamed(context, '/posts');
          },
          text: 'Sign in',
        )
      ],
    );
  }
}
