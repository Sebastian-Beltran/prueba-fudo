// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

final requestHandlerProvider = Provider<RequestHandler>(RequestHandlerImpl.new);

abstract class RequestHandler {
  Future<Response> performGet(String path);
  Future<Response> performPost(String path, Map<String, dynamic> body);
}

class RequestHandlerImpl extends RequestHandler {
  RequestHandlerImpl(this.ref);

  final Ref ref;

  @override
  Future<Response> performGet(String path) async {
    try {
      final res = await http.get(
        _apiURL(path),
        headers: headers,
      );
      print('GET:');
      print(res.body);
      return res;
    } catch (e) {
      print('ERROR GET');
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<Response> performPost(String path, Map<String, dynamic> body) async {
    try {
      final res = await http.post(
        _apiURL(path),
        headers: headers,
        body: utf8.encode(
          json.encode(body),
        ),
      );
      print('POST:');
      print(res.body);
      return res;
    } catch (e) {
      print('ERROR POST');
      print(e.toString());
      rethrow;
    }
  }

  Uri _apiURL(String path) {
    return Uri.parse('$basePath$path');
  }

  final String basePath = 'https://jsonplaceholder.typicode.com';

  final headers = <String, String>{
    'Accept': 'application/json',
  };
}
