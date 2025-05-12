import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String imageUrl;
  final double rating;
  final int duration; // in minutes
  final double price;
  final List<String> topics;
  final String language;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.imageUrl,
    required this.rating,
    required this.duration,
    required this.price,
    required this.topics,
    required this.language,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
