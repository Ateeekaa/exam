part of 'course_bloc.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoadSuccess extends CourseState {
  final List<Course> courses;

  const CourseLoadSuccess(this.courses);

  @override
  List<Object> get props => [courses];
}

class CourseLoadFailure extends CourseState {
  final String error;

  const CourseLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
