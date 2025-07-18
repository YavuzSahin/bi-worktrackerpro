import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/work_log.dart';

class ApiService {
  static const String baseUrl = 'http://your-server-url.com'; // Update this
  
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
  };

  Map<String, String> _headersWithAuth(String token) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: _headers,
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Login failed');
    }
  }

  Future<void> logout(String token) async {
    await http.post(
      Uri.parse('$baseUrl/api/logout'),
      headers: _headersWithAuth(token),
    );
  }

  Future<WorkStatus> getWorkStatus(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/status'),
      headers: _headersWithAuth(token),
    );

    if (response.statusCode == 200) {
      return WorkStatus.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get work status');
    }
  }

  Future<WorkLog> checkIn(String token, CheckInRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/checkin'),
      headers: _headersWithAuth(token),
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WorkLog.fromJson(data['workLog']);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Check-in failed');
    }
  }

  Future<WorkLog> checkOut(String token, CheckInRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/checkout'),
      headers: _headersWithAuth(token),
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WorkLog.fromJson(data['workLog']);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Check-out failed');
    }
  }

  Future<List<WorkLog>> getWorkLogs(String token, {DateTime? startDate, DateTime? endDate}) async {
    String url = '$baseUrl/api/logs';
    Map<String, String> queryParams = {};
    
    if (startDate != null) {
      queryParams['startDate'] = startDate.toIso8601String();
    }
    if (endDate != null) {
      queryParams['endDate'] = endDate.toIso8601String();
    }
    
    if (queryParams.isNotEmpty) {
      url += '?' + queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
    }

    final response = await http.get(
      Uri.parse(url),
      headers: _headersWithAuth(token),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> logsJson = data['logs'];
      return logsJson.map((json) => WorkLog.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get work logs');
    }
  }
}