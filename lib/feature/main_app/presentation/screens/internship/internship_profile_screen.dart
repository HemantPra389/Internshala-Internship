import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:internshala/core/constants.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/icons.dart';
import '../../../../../core/util_fun.dart';

class InternshipProfileScreen extends StatefulWidget {
  const InternshipProfileScreen({super.key});

  @override
  State<InternshipProfileScreen> createState() =>
      _InternshipProfileScreenState();
}

class _InternshipProfileScreenState extends State<InternshipProfileScreen> {
  var profile_list_box = Hive.box(AppConstants.profileBox);
  late List<int> chipTagsList = [];

  List<String> filteredProfileList = AppConstants.internship_profile_list;

  final TextEditingController _textdateEditingController =
      TextEditingController();

  @override
  void initState() {
    getChipData();
    super.initState();
  }

  Future getChipData() async {
    if (chipTagsList.isEmpty) {
      chipTagsList = profile_list_box.get('key') ?? [];
    }
  }

  @override
  void dispose() {
    _textdateEditingController.dispose();
    super.dispose();
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
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              profile_list_box.clear();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: mediaQuery.width * .02),
              alignment: Alignment.center,
              child:
                  UtilFun.fredokaText("Clear all", color: AppColors.main_blue),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              profile_list_box.put('key', chipTagsList);
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: mediaQuery.width * .02,
                  vertical: mediaQuery.height * .01),
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * .08,
              ),
              decoration: BoxDecoration(
                  color: AppColors.main_blue,
                  borderRadius: BorderRadius.circular(4)),
              alignment: Alignment.center,
              child: UtilFun.fredokaText("Apply", color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: mediaQuery.width * .06,
          right: mediaQuery.width * .06,
          top: mediaQuery.height * .02,
        ),
        child: Column(
          children: [
            TextField(
              controller: _textdateEditingController,
              onChanged: (value) {
                setState(() {
                  filteredProfileList = AppConstants.internship_profile_list
                      .where((profile) => profile.toLowerCase().contains(
                          _textdateEditingController.text.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Choose profile",
              ),
            ),
            UtilFun.vbox(mediaQuery.height * .02),
            Expanded(
              child: ListView(
                children: [
                  filteredProfileList.isEmpty
                      ? Center(
                          child: UtilFun.fredokaText("No search found!!!"),
                        )
                      : ChipsChoice.multiple(
                          value: chipTagsList,
                          onChanged: (value) {
                            setState(() {
                              chipTagsList = value;
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
                            source: filteredProfileList,
                            value: (index, item) => index,
                            label: (index, item) => item,
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
