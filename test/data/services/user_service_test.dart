import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:prueba_fudo/core/api/request_handler.dart';
import 'package:prueba_fudo/data/models/user_model.dart';
import 'package:prueba_fudo/data/services/user_service_impl.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([RequestHandler])
void main() {
  final client = MockRequestHandler();
  final service = UserServiceImpl(client: client);

  group('Testing User service', () {
    group('Testing get list users', () {
      test('Get list user success', () async {
        const path = '/users';
        final response = Response('''
          [
            {
              "id": 1,
              "name": "User test"
            },
            {
              "id": 2,
              "name": "User test"
            }
          ]
        ''', 200);
        when(client.performGet(path)).thenAnswer((_) async => response);
        final res = await service.getUsers();
        final data = json.decode(response.body);
        verify(client.performGet(path)).called(1);
        expect(client.performGet(path), completes);
        expect(
            res.right,
            List<UserModel>.from(data.map((dynamic item) =>
                UserModel.fromJson(item as Map<String, dynamic>))));
      });
      test('Get list user failure', () async {
        const path = '/users';
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
  });
}
