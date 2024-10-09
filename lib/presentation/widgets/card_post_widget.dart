import 'package:flutter/material.dart';

class CardPostWidget extends StatelessWidget {
  const CardPostWidget({
    required this.title,
    required this.body,
    required this.id,
    super.key,
  });

  final String title;
  final String body;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(20),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: ListTile(
        leading: const Icon(Icons.post_add_outlined),
        trailing: Text(
          id.toString(),
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          body,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
