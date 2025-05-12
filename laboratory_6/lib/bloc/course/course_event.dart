part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class LoadCourses extends CourseEvent {}

class LoadEnrolledCourses extends CourseEvent {
  final String userId;

  const LoadEnrolledCourses(this.userId);

  @override
  List<Object> get props => [userId];
}

class EnrollInCourse extends CourseEvent {
  final String userId;
  final String courseId;

  const EnrollInCourse(this.userId, this.courseId);

  @override
  List<Object> get props => [userId, courseId];
}
