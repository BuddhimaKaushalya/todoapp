import 'dart:convert';
import 'package:dio/dio.dart';
import 'task.dart';

class TaskService {
  late final Dio _dio;
  final JsonEncoder _encoder = JsonEncoder();

  static final TaskService _instance = TaskService.internal();
  static const String baseUrl = 'http://192.168.1.11:8065';

  TaskService.internal();

  static TaskService get instance => _instance;

  Future<void> initClient(String token) async {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  Future<void> createTask(String taskName, DateTime dateTime) async {
    try {
      final response = await _dio.post(
        '$baseUrl/users/tasks',
        data: {'name': taskName},
      );
      return response.data;
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Task>> getTasks(String username, String token) async {
    try {
      final response = await _dio.get(
        '$baseUrl/tasks',
        queryParameters: {'username': username},
      );

      final responseData = response.data;
      if (responseData is List) {
        // Convert each JSON object in the list to a Task object
        final List<Task> tasks = responseData
            .map((taskJson) => Task.fromJson(taskJson as Map<String, dynamic>))
            .toList();
        return tasks;
      } else {
        throw Exception('Unexpected response data format: $responseData');
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }

 Future<void> updateTask(int taskId, String taskName, DateTime dateTime) async {
  try {
    final response = await _dio.put(
      '$baseUrl/users/tasks/$taskId',
      data: {
        'name': taskName,
        'dateTime': dateTime.toIso8601String(), // Encode DateTime to ISO 8601 format
      },
    );

    if (response.statusCode == 200) {
      // Task updated successfully
      return;
    } else {
      // Handle other HTTP status codes
      throw Exception('Failed to update task: ${response.statusCode}');
    }
  } on DioError catch (e) {
    if (e.response != null) {
      // Handle DioError with response
      throw Exception(e.response!.data['detail'] ?? 'Failed to update task');
    } else {
      // Handle DioError without response
      throw Exception('Failed to update task: ${e.message}');
    }
  } catch (e) {
    // Handle other exceptions
    rethrow;
  }
}

  Future<bool> deleteTask(int index, int taskId) async {
    try {
      final response = await _dio.delete('$baseUrl/tasks/$taskId');
      if (response.statusCode == 200) {
        // Task deleted successfully.
        return true;
      } else if (response.statusCode == 404) {
        // Task not found.
        return false;
      } else {
        final responseData = response.data;
        if (responseData != null && responseData['detail'] != null) {
          throw Exception(responseData['detail'].toString());
        } else {
          throw Exception('Failed to delete task: ${response.statusCode}');
        }
      }
    } on DioError catch (e) {
      throw Exception(e.response?.data['detail'] ?? e.toString());
    } catch (e) {
      rethrow;
    }
  }
}