import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laboratory_6/bloc/course/course_bloc.dart';
import 'package:laboratory_6/bloc/user/user_bloc.dart';
import 'package:laboratory_6/model/course.dart';
import 'package:easy_localization/easy_localization.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadEnrolledCourses();
  }

  void _loadEnrolledCourses() {
    final userState = context.read<UserBloc>().state;
    if (userState is UserLoadSuccess) {
      context.read<CourseBloc>().add(LoadEnrolledCourses(userState.profile.id));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_courses'.tr()),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'in_progress'.tr()),
            Tab(text: 'completed'.tr()),
          ],
        ),
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseLoadSuccess) {
            if (state.courses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('no_enrolled_courses'.tr()),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to courses page
                      },
                      child: Text('browse_courses'.tr()),
                    ),
                  ],
                ),
              );
            }

            return TabBarView(
              controller: _tabController,
              children: [
                _buildCourseList(state.courses, isCompleted: false),
                _buildCourseList(state.courses, isCompleted: true),
              ],
            );
          } else if (state is CourseLoadFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('error_loading_courses'.tr()),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadEnrolledCourses,
                    child: Text('retry'.tr()),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCourseList(List<Course> courses, {required bool isCompleted}) {
    // TODO: Add completion status to Course model and filter accordingly
    final displayedCourses = courses;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: displayedCourses.length,
      itemBuilder: (context, index) {
        final course = displayedCourses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                course.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  );
                },
              ),
            ),
            title: Text(course.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: 0.6, // TODO: Add progress tracking
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 4),
                Text('60% ${'completed'.tr()}'), // TODO: Add progress tracking
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.play_circle_outline),
              onPressed: () {
                // TODO: Navigate to course content
              },
            ),
            onTap: () {
              // TODO: Navigate to course details
            },
          ),
        );
      },
    );
  }
}
