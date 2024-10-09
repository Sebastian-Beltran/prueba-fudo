import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/core/constants/palette.dart';
import 'package:prueba_fudo/data/models/post_model.dart';
import 'package:prueba_fudo/data/providers/post_provider.dart';
import 'package:prueba_fudo/presentation/widgets/custom_app_bar.dart';
import 'package:prueba_fudo/presentation/widgets/custom_button.dart';
import 'package:prueba_fudo/presentation/widgets/custom_text_field.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _titleController = TextEditingController();

  final _bodyController = TextEditingController();

  bool get isValid {
    if (_titleController.text != '' && _bodyController.text != '') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Card(
          color: Palette.white,
          elevation: 3,
          margin: const EdgeInsets.all(40),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  'Create new Post',
                  style: TextStyle(
                    color: Palette.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  controller: _titleController,
                  labelText: 'Title',
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  controller: _bodyController,
                  labelText: 'Body',
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 70),
                CustomButton(
                  text: 'Create',
                  isEnabled: isValid,
                  onPressed: () => onPressed(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPressed(BuildContext context) async {
    await ref.read(postProvider.notifier).createPost(
          Post(
            id: 1,
            title: _titleController.text,
            body: _bodyController.text,
            userId: 1,
          ),
          context,
        );
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
