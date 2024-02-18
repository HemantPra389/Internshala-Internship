import 'package:flutter/material.dart';
import 'package:internshala/core/util_fun.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: UtilFun.fredokaText("Courses"),
    );
  }
}