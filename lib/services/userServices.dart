import 'dart:convert';
import 'package:dio/dio.dart';

class NetworkService {
  late final Dio _dio;

  static final NetworkService _instance = NetworkService._internal();

  static const String baseUrl = 'http://192.168.1.11:8065';
  

  NetworkService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
      ),
    );
  }

  static NetworkService get instance => _instance;

  Future<dynamic> registerUser(String name, String userName, String email,
      String password, String confirmedPassword) async {
    try {
      final response = await _dio.post(
        '/users',
        data: {
          'name': name,
          'username': userName,
          'email': email,
          'password': password,
          'confirmedPassword': confirmedPassword,
        },
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> loginUser(String userName, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          'username': userName,
          'password': password,
        },
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }
}
