import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/students_actions.dart';
import 'package:flutter_bloc_example/bloc/students_bloc.dart';
import 'package:flutter_bloc_example/bloc/students_state.dart';
import 'package:flutter_bloc_example/services/get_students.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentsBloc>(
      create: (_) => StudentsBloc(getStudents)
        ..add(
          RequestStudents(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Student List'),
        ),
        body: BlocConsumer<StudentsBloc, StudentsState>(
          listener: (context, studentsState) {},
          builder: (context, studentsState) {
            if (studentsState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (studentsState.error != null) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text(studentsState.error!),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            } else {
              final students = studentsState.list;
              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students.elementAt(index);
                  return ListTile(
                    title: Text(student.name),
                    subtitle: Text('Age: ${student.age}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
