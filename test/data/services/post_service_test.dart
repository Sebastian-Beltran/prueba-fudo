import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prueba_fudo/core/api/request_handler.dart';
import 'package:prueba_fudo/data/models/post_model.dart';
import 'package:prueba_fudo/data/services/post_service_impl.dart';

import 'post_service_test.mocks.dart';

@GenerateMocks([RequestHandler])
void main() {
  final client = MockRequestHandler();
  final service = PostServiceImpl(client: client);

  group('Testing Post service', () {
    group('Testing get list post', () {
      test('Get list post success', () async {
        const path = '/posts';
        final response = Response('''
          [
            {
              "userId": 1,
              "id": 1,
              "title": "Title test",
              "body": "Body test"
            },
            {
              "userId": 1,
              "id": 2,
              "title": "Title test",
              "body": "Body test"
            }
          ]
        ''', 200);
        when(client.performGet(path)).thenAnswer((_) async => response);
        final res = await service.getPostList();
        final data = json.decode(response.body);
        verify(client.performGet(path)).called(1);
        expect(client.performGet(path), completes);
        expect(
            res.right,
            List<Post>.from(
              data.map(
                (dynamic item) => Post.fromJson(item as Map<String, dynamic>),
              ),
            ));
      });
      test('Get list post failure', () async {
        const path = '/posts';
        const error = 'Error';
        when(client.performGet(path)).thenThrow(error);
        try {
          await client.performGet(path);
        } catch (e) {
          expect(e, error);
          expect(e, isA<String>());
        }
      });
    });
    group('Testing create post', () {
      test('Create post success', () async {
        const path = '/posts';
        const post = Post(
          id: 1,
          title: 'Title test',
          body: 'Body test',
          userId: 1,
        );
        final body = <String, dynamic>{
          'title': post.title,
          'body': post.body,
          'userId': post.userId,
        };
        final response = Response('''
            {
              "userId": 1,
              "id": 1,
              "title": "Title test",
              "body": "Body test"
            }
            
        ''', 200);
        when(client.performPost(path, body)).thenAnswer((_) async => response);
        final res = await service.createPost(post: post);
        verify(client.performPost(path, body)).called(1);
        expect(client.performPost(path, body), completes);
        expect(
          res,
          'Post creado correctamente',
        );
      });
      test('Create post failure', () async {
        const path = '/posts';
        const error = 'Error';
        const post = Post(
          id: 1,
          title: 'Title test',
          body: 'Body test',
          userId: 1,
        );
        final body = <String, dynamic>{
          'title': post.title,
          'body': post.body,
          'userId': post.userId,
        };
        when(client.performPost(path, body)).thenThrow(error);
        try {
          await service.createPost(post: post);
        } catch (e) {
          verify(client.performPost(path, body)).called(1);
          expect(e, error);
          expect(e, isA<String>());
        }
      });
    });
  });
}
