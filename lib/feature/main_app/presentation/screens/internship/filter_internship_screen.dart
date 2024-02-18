import 'dart:math';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:internshala/core/colors.dart';
import 'package:internshala/core/constants.dart';
import 'package:internshala/feature/main_app/domain/entities/internship_filter_entity.dart';
import 'package:internshala/feature/main_app/presentation/bloc/internship/bloc/internship_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/icons.dart';
import '../../../../../core/util_fun.dart';

class FilterInternshipScreen extends StatefulWidget {
  const FilterInternshipScreen({super.key});

  @override
  State<FilterInternshipScreen> createState() => _FilterInternshipScreenState();
}

class _FilterInternshipScreenState extends State<FilterInternshipScreen> {
  List<int> course_duration_list = [1, 2, 3, 4, 6, 12, 24, 36];

  bool is_course_duration_selected = false;

  var profile_list_box = Hive.box(AppConstants.profileBox);
  late List<int> chipTagsList1;
  var city_list_box = Hive.box(AppConstants.cityBox);
  late List<int> chipTagsList2;
  var duration_box = Hive.box(AppConstants.durationBox);
  late int course_duration;
  @override
  void initState() {
    getChipData();
    super.initState();
  }

  Future getChipData() async {
    chipTagsList1 = profile_list_box.get('key') ?? [];

    chipTagsList2 = city_list_box.get('key') ?? [];

    course_duration = duration_box.get('key') ?? 3;
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 42,
        titleSpacing: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: AppColors.black_shade_2,
          ),
        ),
        title: UtilFun.fredokaText("Filters",
            size: 22, fontWeight: FontWeight.bold),
        actions: [
          SvgPicture.asset(
            AppIcons.bookmark_icon,
            fit: BoxFit.scaleDown,
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SvgPicture.asset(
              AppIcons.comment_icon,
              fit: BoxFit.scaleDown,
              height: 28,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width * .04,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilterTitleWidget(title: "PROFILE", mediaQuery: mediaQuery),
              ChipsChoice.multiple(
                value: chipTagsList1,
                onChanged: (value) {
                  setState(() {
                    chipTagsList1 = value;
                    profile_list_box.put('key', chipTagsList1);
                  });
                },
                wrapped: true,
                padding: EdgeInsets.zero,
                choiceStyle: C2ChipStyle.filled(
                  selectedStyle: C2ChipStyle.filled(
                    color: AppColors.main_blue,
                    backgroundOpacity: .6,
                    checkmarkColor: Colors.white,
                    foregroundStyle: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Fredoka',
                      fontSize: 14,
                    ),
                  ),
                  color: Colors.blueGrey,
                  backgroundOpacity: .2,
                  foregroundStyle: TextStyle(
                    color: AppColors.black_shade_2,
                    fontFamily: 'Fredoka',
                    fontSize: 14,
                  ),
                ),
                choiceItems: C2Choice.listFrom(
                  source: AppConstants.internship_profile_list,
                  value: (index, item) => index,
                  label: (index, item) => item,
                ),
              ),
              FilterTitleWidget(title: "CITY", mediaQuery: mediaQuery),
              ChipsChoice.multiple(
                value: chipTagsList2,
                onChanged: (value) {
                  setState(() {
                    chipTagsList2 = value;
                    print(chipTagsList2);
                    city_list_box.put('key', chipTagsList2);
                  });
                },
                wrapped: true,
                padding: EdgeInsets.zero,
                choiceStyle: C2ChipStyle.filled(
                  selectedStyle: C2ChipStyle.filled(
                    color: AppColors.main_blue,
                    backgroundOpacity: .6,
                    checkmarkColor: Colors.white,
                    foregroundStyle: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Fredoka',
                      fontSize: 14,
                    ),
                  ),
                  color: Colors.blueGrey,
                  backgroundOpacity: .2,
                  foregroundStyle: TextStyle(
                    color: AppColors.black_shade_2,
                    fontFamily: 'Fredoka',
                    fontSize: 14,
                  ),
                ),
                choiceItems: C2Choice.listFrom(
                  source: AppConstants.cities,
                  value: (index, item) => index,
                  label: (index, item) => item,
                ),
              ),
              FilterTitleWidget(
                  title: "MAXIMUM DURATION (IN MONTHS)",
                  mediaQuery: mediaQuery),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Choose Duration",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: mediaQuery.width * .04),
                ),
                value: course_duration,
                items: course_duration_list
                    .map((element) => DropdownMenuItem(
                        value: element,
                        child: UtilFun.fredokaText(element.toString())))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    course_duration = value!;
                    is_course_duration_selected = true;
                    duration_box.put('key', course_duration);
                  });
                  print(course_duration.toString() + " course duration");
                  print(is_course_duration_selected.toString() +
                      " course duration");
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: mediaQuery.height * .07,
        width: mediaQuery.width,
        margin: EdgeInsets.symmetric(vertical: mediaQuery.height * .01),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  BlocProvider.of<InternshipBloc>(context)
                      .add(GetInternshipData());
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: mediaQuery.width * .02),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.main_blue),
                      borderRadius: BorderRadius.circular(4)),
                  alignment: Alignment.center,
                  child: UtilFun.fredokaText("Clear all",
                      color: AppColors.main_blue),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () async {
                  BlocProvider.of<InternshipBloc>(context).add(
                      GetInternshipFilterData(
                          internshipFilterEntity: InternshipFilterEntity(
                              profile_name:
                                  await profile_list_box.get('key') ?? [],
                              location_names:
                                  await city_list_box.get('key') ?? [],
                              duration: "$course_duration Months",
                              is_duration_selected:
                                  is_course_duration_selected)));
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: mediaQuery.width * .02),
                  decoration: BoxDecoration(
                      color: AppColors.main_blue,
                      borderRadius: BorderRadius.circular(4)),
                  alignment: Alignment.center,
                  child: UtilFun.fredokaText("Apply", color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilterTitleWidget extends StatelessWidget {
  const FilterTitleWidget({
    super.key,
    required this.title,
    required this.mediaQuery,
  });

  final Size mediaQuery;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UtilFun.vbox(mediaQuery.height * .03),
        UtilFun.fredokaText(title, color: AppColors.black_shade_3, size: 14),
        UtilFun.vbox(mediaQuery.height * .01),
      ],
    );
  }
}

class FilterCheckBoxWidget extends StatelessWidget {
  FilterCheckBoxWidget({
    super.key,
    required this.title,
    required this.fun,
    required this.status,
    required this.mediaQuery,
  });

  final Size mediaQuery;
  final String title;
  final VoidCallback fun;
  bool status;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: status,
          onChanged: (value) {
            fun();
          },
          visualDensity: VisualDensity.compact,
        ),
        UtilFun.hbox(mediaQuery.width * .01),
        UtilFun.fredokaText(
          title,
          size: 16,
        ),
      ],
    );
  }
}
