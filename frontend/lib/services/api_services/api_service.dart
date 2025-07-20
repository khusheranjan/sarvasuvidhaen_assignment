import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kpa_erp/constants/api_constant.dart';
import 'package:kpa_erp/services/api_services/api_exception.dart';

class ApiService {
  /// Adds authorization header if token is available and valid
  static Map<String, String> _getHeadersWithAuth(dynamic body) {
    // Start with basic headers
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    // Extract token from body if available
    String? token;
    if (body != null && body.containsKey('token')) {
      token = body['token'];
    }

    // Add Authorization header if token is valid
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  /// Prepares request body - for debugging, keep token in body to match Postman
  static Map<String, dynamic> _prepareRequestBody(dynamic body) {
    if (body == null) return {};

    // Create a copy of the body to avoid modifying the original
    Map<String, dynamic> requestBody = Map<String, dynamic>.from(body);

    // TEMPORARY: Keep token in body to match Postman behavior for debugging
    // TODO: Remove this after confirming API authentication method
    // if (requestBody.containsKey('token')) {
    //   requestBody.remove('token');
    // }

    return requestBody;
  }

  static Future<dynamic> post(String endpoint, dynamic body, {String? overrideBaseUrl}) async {
  try {
    Map<String, String> headers = _getHeadersWithAuth(body);
    Map<String, dynamic> requestBody = _prepareRequestBody(body);

    final fullUrl = Uri.parse('${overrideBaseUrl ?? ApiConstant.baseUrl}$endpoint');

    final response = await http.post(
      fullUrl,
      headers: headers,
      body: jsonEncode(requestBody),
    );

    return _handleResponse(response);
  } catch (e) {
    if (e is ApiException) rethrow;
    throw ApiException(500, 'Network error: ${e.toString()}');
  }
}

static Future<dynamic> get(String endpoint, dynamic body, {String? overrideBaseUrl}) async {
  try {
    Map<String, String> headers = _getHeadersWithAuth(body);
    final fullUrl = Uri.parse('${overrideBaseUrl ?? ApiConstant.baseUrl}$endpoint');

    final response = await http.get(
      fullUrl,
      headers: headers,
    );

    return _handleResponse(response);
  } catch (e) {
    if (e is ApiException) rethrow;
    throw ApiException(500, 'Network error: ${e.toString()}');
  }
}

  static Future<dynamic> put(String endpoint, dynamic body) async {
    try {
      // Prepare headers with authorization
      Map<String, String> headers = _getHeadersWithAuth(body);

      // Prepare request body without token
      Map<String, dynamic> requestBody = _prepareRequestBody(body);

      final response = await http.put(
        Uri.parse('${ApiConstant.baseUrl}$endpoint'),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      return _handleResponse(response);
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(500, 'Network error: ${e.toString()}');
    }
  }

  static Future<dynamic> delete(String endpoint, dynamic body) async {
    try {
      // Prepare headers with authorization
      Map<String, String> headers = _getHeadersWithAuth(body);

      // Prepare request body without token
      Map<String, dynamic> requestBody = _prepareRequestBody(body);

      final response = await http.delete(
        Uri.parse('${ApiConstant.baseUrl}$endpoint'),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      return _handleResponse(response);
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      throw ApiException(500, 'Network error: ${e.toString()}');
    }
  }

  static dynamic _handleResponse(http.Response response) {
    if (response.headers['content-type']?.contains('application/pdf') ??
        false) {
      return response.bodyBytes;
    } else if (response.statusCode == 204) {
      return "deleted successfully";
    } else {
      try {
        final jsonResponse = json.decode(response.body);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return jsonResponse;
        } else {
          if (jsonResponse.containsKey('details')) {
            throw DetailedApiException.fromJson(
              response.statusCode,
              jsonResponse,
            );
          } else {
            throw ApiException.fromJson(response.statusCode, jsonResponse);
          }
        }
      } catch (e) {
        if (e is ApiException) {
          rethrow;
        }
        throw ApiException(
          response.statusCode,
          'Failed to parse response: ${response.body}',
        );
      }
    }
  }
}
