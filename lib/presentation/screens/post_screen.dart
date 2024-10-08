import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prueba_fudo/data/providers/post_provider.dart';

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
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Post',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Consumer(
            builder: (builder, ref, child) {
              final postState = ref.watch(postProvider);
              if (postState.isError != null) {
                return Text(postState.isError!);
              } else if (postState.isInitState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(postProvider.notifier).getPostsList();
                });
                return const CircularProgressIndicator();
              } else if (postState.isLoading) {
                return const CircularProgressIndicator();
              } else if (postState.posts!.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: postState.posts!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(postState.posts![index].title),
                      );
                    },
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
