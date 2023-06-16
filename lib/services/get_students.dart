import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_bloc_example/models/student.dart';

Future<Iterable<Student>> getStudents() async {
  const url =
      'https://648ba2a517f1536d65eb1b18.mockapi.io/api/v1/students'; // Replace with your API endpoint

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = convert.jsonDecode(response.body) as List<dynamic>;

      final students = jsonData.map((data) {
        return Student(data['name'], data['age']);
      }).toList();

      return students;
    } else {
      throw Exception('Failed to fetch students');
    }
  } catch (error) {
    throw Exception('An error occurred: $error');
  }
}
