import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laboratory_6/data/repositories/course_repository.dart';
import 'package:laboratory_6/model/course.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository _courseRepository;

  CourseBloc({required CourseRepository courseRepository})
      : _courseRepository = courseRepository,
        super(CourseInitial()) {
    on<LoadCourses>(_onLoadCourses);
    on<LoadEnrolledCourses>(_onLoadEnrolledCourses);
    on<EnrollInCourse>(_onEnrollInCourse);
  }

  Future<void> _onLoadCourses(
    LoadCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final courses = await _courseRepository.getCourses();
      emit(CourseLoadSuccess(courses));
    } catch (e) {
      emit(CourseLoadFailure(e.toString()));
    }
  }

  Future<void> _onLoadEnrolledCourses(
    LoadEnrolledCourses event,
    Emitter<CourseState> emit,
  ) async {
    emit(CourseLoading());
    try {
      final courses = await _courseRepository.getEnrolledCourses(event.userId);
      emit(CourseLoadSuccess(courses));
    } catch (e) {
      emit(CourseLoadFailure(e.toString()));
    }
  }

  Future<void> _onEnrollInCourse(
    EnrollInCourse event,
    Emitter<CourseState> emit,
  ) async {
    try {
      await _courseRepository.enrollInCourse(event.userId, event.courseId);
      add(LoadEnrolledCourses(event.userId));
    } catch (e) {
      emit(CourseLoadFailure(e.toString()));
    }
  }
}
