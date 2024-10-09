import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/core/constants/palette.dart';
import 'package:prueba_fudo/data/models/user_model.dart';
import 'package:prueba_fudo/data/providers/post_provider.dart';
import 'package:prueba_fudo/data/providers/user_provider.dart';
import 'package:prueba_fudo/presentation/widgets/card_post_widget.dart';
import 'package:prueba_fudo/presentation/widgets/circular_progress.dart';
import 'package:prueba_fudo/presentation/widgets/custom_app_bar.dart';
import 'package:prueba_fudo/presentation/widgets/custom_drop_down_search.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(postProvider.notifier).getPostsList();
      ref.read(userProvider.notifier).getUsers();
    });
    super.initState();
  }

  UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Consumer(builder: (builder, ref, child) {
            final userState = ref.watch(userProvider);
            if (userState.isError != null) {
              return const Center(
                child: Text(
                  'Error al traer el listado de usuarios',
                ),
              );
            } else if (userState.isInitState) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ref.read(postProvider.notifier).getPostsList();
              });
              return const CircularProgress();
            } else if (userState.isLoading) {
              return const CircularProgress();
            } else if (userState.users!.isNotEmpty) {
              final users = userState.users!;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomDropDownSearch<UserModel>(
                  itemAsString: (s) => s.name,
                  items: users,
                  onChanged: (s) {
                    ref.read(postProvider.notifier).getPostsList(userId: s!.id);
                  },
                  itemBuilder: (context, item, isDisabled, isSelected) {
                    // return Text(item.name);
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: getRandomColor(),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            item.name.substring(0, 1),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      title: Text(item.name),
                    );
                  },
                ),
              );
            } else {
              return const CircularProgress();
            }
          }),
          Consumer(
            builder: (builder, ref, child) {
              final postState = ref.watch(postProvider);
              if (postState.isError != null) {
                return const Center(
                  child: Text(
                    'Error al traer el listado de Posts',
                  ),
                );
              } else if (postState.isInitState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(postProvider.notifier).getPostsList();
                });
                return const CircularProgress();
              } else if (postState.isLoading) {
                return const CircularProgress();
              } else if (postState.posts!.isNotEmpty) {
                final posts = postState.posts!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return CardPostWidget(
                        title: posts[index].title,
                        body: posts[index].body,
                        id: posts[index].id,
                      );
                    },
                  ),
                );
              } else {
                return const CircularProgress();
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        backgroundColor: Palette.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Color getRandomColor() {
    final Random random = Random();
    return Palette.colorsList[random.nextInt(Palette.colorsList.length)];
  }
}
