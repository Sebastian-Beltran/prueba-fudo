import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/core/constants/colors.dart';
import 'package:prueba_fudo/data/models/user_model.dart';
import 'package:prueba_fudo/data/providers/auth_provider.dart';
import 'package:prueba_fudo/presentation/widgets/custom_button.dart';
import 'package:prueba_fudo/presentation/widgets/custom_text_field.dart';

class LoginWidgets extends ConsumerStatefulWidget {
  const LoginWidgets({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends ConsumerState<LoginWidgets> {
  final _userController = TextEditingController();

  final _passwordController = TextEditingController();

  bool get isValid {
    if (_userController.text != '' && _passwordController.text != '') {
      return true;
    }
    return false;
  }

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
        CustomTextFormField(
          controller: _userController,
          labelText: 'User',
          onChanged: (val) {
            setState(() {});
          },
        ),
        const SizedBox(height: 30),
        CustomTextFormField(
          isPassword: true,
          controller: _passwordController,
          labelText: 'Password',
          onChanged: (val) {
            setState(() {});
          },
        ),
        const SizedBox(height: 60),
        CustomButton(
          isEnabled: isValid,
          onPressed: () => onPressed(
            _userController.text,
            _passwordController.text,
          ),
          text: 'Sign in',
        )
      ],
    );
  }

  void onPressed(String userName, String userPassword) {
    final user = UserModel(userName: userName, password: userPassword);
    ref.read(authProvider.notifier).login(user, context);
  }
}
