// Define the states
import 'package:flutter_bloc_example/models/student.dart';

class StudentsState {
  final bool isLoading;
  final String? error;
  final Iterable<Student> list;

  StudentsState({
    required this.isLoading,
    required this.error,
    required this.list,
  });
}
