import 'package:flutter/material.dart';
import 'package:internshala/core/util_fun.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: UtilFun.fredokaText("Jobs"),
    );
  }
}