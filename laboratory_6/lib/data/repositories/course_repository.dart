import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laboratory_6/model/course.dart';

class CourseRepository {
  final FirebaseFirestore _firestore;

  CourseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Course>> getCourses() async {
    try {
      final snapshot = await _firestore.collection('courses').get();
      return snapshot.docs
          .map((doc) => Course.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Failed to load courses: $e');
    }
  }

  Future<Course> getCourseById(String id) async {
    try {
      final doc = await _firestore.collection('courses').doc(id).get();
      if (!doc.exists) {
        throw Exception('Course not found');
      }
      return Course.fromJson({...doc.data()!, 'id': doc.id});
    } catch (e) {
      throw Exception('Failed to load course: $e');
    }
  }

  Future<void> enrollInCourse(String userId, String courseId) async {
    try {
      await _firestore.collection('enrollments').add({
        'userId': userId,
        'courseId': courseId,
        'enrolledAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to enroll in course: $e');
    }
  }

  Future<List<Course>> getEnrolledCourses(String userId) async {
    try {
      final enrollments = await _firestore
          .collection('enrollments')
          .where('userId', isEqualTo: userId)
          .get();

      final courseIds = enrollments.docs.map((doc) => doc.get('courseId') as String).toList();
      
      if (courseIds.isEmpty) return [];

      final coursesSnapshot = await _firestore
          .collection('courses')
          .where(FieldPath.documentId, whereIn: courseIds)
          .get();

      return coursesSnapshot.docs
          .map((doc) => Course.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw Exception('Failed to load enrolled courses: $e');
    }
  }
}
