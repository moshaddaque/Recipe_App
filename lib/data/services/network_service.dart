import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipe_app/data/models/network_response.dart';

class NetworkService {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      debugPrint(url);
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, responseData: e.toString());
    }
  }
}
