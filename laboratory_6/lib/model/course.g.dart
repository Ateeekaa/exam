// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      instructor: json['instructor'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      duration: (json['duration'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      topics:
          (json['topics'] as List<dynamic>).map((e) => e as String).toList(),
      language: json['language'] as String,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'instructor': instance.instructor,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      'duration': instance.duration,
      'price': instance.price,
      'topics': instance.topics,
      'language': instance.language,
    };
