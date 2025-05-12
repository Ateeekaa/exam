import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laboratory_6/bloc/course/course_bloc.dart';
import 'package:laboratory_6/model/course.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  List<Course> _filteredCourses = [];
  List<Course> _allCourses = [];

  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(LoadCourses());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCourses(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredCourses = _allCourses;
      });
      return;
    }

    setState(() {
      _filteredCourses = _allCourses.where((course) {
        final titleMatch = course.title.toLowerCase().contains(query.toLowerCase());
        final descriptionMatch =
            course.description.toLowerCase().contains(query.toLowerCase());
        final instructorMatch =
            course.instructor.toLowerCase().contains(query.toLowerCase());
        return titleMatch || descriptionMatch || instructorMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search_courses'.tr()),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'search_hint'.tr(),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              onChanged: _filterCourses,
            ),
          ),
          Expanded(
            child: BlocConsumer<CourseBloc, CourseState>(
              listener: (context, state) {
                if (state is CourseLoadSuccess) {
                  setState(() {
                    _allCourses = state.courses;
                    _filteredCourses = state.courses;
                  });
                }
              },
              builder: (context, state) {
                if (state is CourseLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CourseLoadFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('error_loading_courses'.tr()),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<CourseBloc>().add(LoadCourses());
                          },
                          child: Text('retry'.tr()),
                        ),
                      ],
                    ),
                  );
                }

                if (_filteredCourses.isEmpty) {
                  return Center(
                    child: Text('no_courses_found'.tr()),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredCourses.length,
                  itemBuilder: (context, index) {
                    final course = _filteredCourses[index];
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
                        subtitle: Text(
                          course.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          '\$${course.price}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          // TODO: Navigate to course details
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
