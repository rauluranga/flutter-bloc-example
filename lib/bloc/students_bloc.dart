import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/students_actions.dart';
import 'package:flutter_bloc_example/bloc/students_state.dart';
import 'package:flutter_bloc_example/models/student.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentsBloc(Future<Iterable<Student>> Function() provider)
      : super(
          StudentsState(
            isLoading: false,
            error: null,
            list: [],
          ),
        ) {
    on<RequestStudents>(
      (event, emit) async {
        // let cmd = RequestStudetnsCommand(event, emit, state);
        // cmd.execute();

        //
        emit(StudentsState(
          isLoading: true,
          error: null,
          list: [],
        ));
        //
        await Future.delayed(const Duration(seconds: 2));
        //
        try {
          final students = await provider();

          emit(StudentsState(
            isLoading: false,
            error: null,
            list: students,
          ));
        } catch (error) {
          emit(StudentsState(
            isLoading: false,
            error: error.toString(),
            list: [],
          ));
        }
      },
    );
  }
}
