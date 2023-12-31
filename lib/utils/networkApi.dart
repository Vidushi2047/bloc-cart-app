import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkApi {
  static Future<dynamic> getResponse({
    required String url,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      print(response.statusCode);
      return jsonDecode(response.body);
    } on SocketException {
      print('No internet Connection');
    }
  }

  static Future<dynamic> postFormData({
    required String url,
    required String httpRequestType,
    Map<String, String>? headers,
    File? image,
    required Map<String, String> body,
  }) async {
    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest(
        httpRequestType,
        uri,
      );

      if (image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', image.path),
        );
      }

      request.headers.addAll(headers ?? {});

      request.fields.addAll(body);

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      return jsonDecode(response.body);

      // if (response.statusCode == 400) {
      //   return "Error uploading data";
      // }

      // if (response.statusCode == 201) {
      //   return jsonDecode(response.body);
      // }
    } on SocketException {
      print('No internet Connection');
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getMultipleRequestsData({
    required List<String> url,
    Map<String, String>? headers,
  }) async {
    try {
      var responses = await Future.wait([
        for (int i = 0; i < url.length; i++)
          getResponse(url: url[i], headers: headers),
        // getResponse(url: url[1], headers: headers),
        // getResponse(url: url[2], headers: headers),
      ]);

      if (responses.isNotEmpty) {
        return responses;
      }
    } on SocketException {
      print('No internet Connection');
    }
  }

  static Future<dynamic> post({
    required String url,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      print(body);
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      return jsonDecode(response.body);
      // if (response.statusCode == 201) {
      //   return jsonDecode(response.body);
      // } else {
      //   return null;
      // }
    } on SocketException {
      return "No Internet Found";
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<dynamic> post200({
    required String url,
    Map<String, String>? headers,
    Map? body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      return jsonDecode(response.body);
      // if (response.statusCode == 200) {
      //   return jsonDecode(response.body);
      // } else {
      //   return null;
      // }
    } on SocketException {
      return "No Internet Found";
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<dynamic> put200(
    String url,
    Map<String, String>? headers,
    dynamic body,
  ) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      return jsonDecode(response.body);
      // if (response.statusCode == 200) {
      //   return jsonDecode(response.body);
      // } else {
      //   return null;
      // }
    } on SocketException {
      return "No Internet Found";
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<dynamic> delete({
    required String url,
    Map<String, String>? headers,
    Map? body,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      return jsonDecode(response.body);
      // if (response.statusCode == 200) {
      //   return jsonDecode(response.body);
      // } else {
      //   return null;
      // }
    } on SocketException {
      return "No Internet Found";
    } on Exception catch (e) {
      print(e);
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson;

      case 401:
    }
  }

  static Future<dynamic> getResponseWithParams({
    required String url,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse(url).replace(queryParameters: queryParams);
      print('uri+++++++++++$uri');
      final response = await http.get(uri, headers: headers);
      print(response.statusCode);
      return jsonDecode(response.body);
    } on SocketException {
      return "No Internet Found";
    } on Exception catch (e) {
      print(e);
    }
  }
}
