import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internshala/core/constants.dart';
import 'package:internshala/core/icons.dart';
import 'package:internshala/core/util_fun.dart';
import 'package:internshala/feature/main_app/presentation/bloc/internship/bloc/internship_bloc.dart';
import 'package:internshala/feature/main_app/presentation/screens/clubs/clubs_screen.dart';
import 'package:internshala/feature/main_app/presentation/screens/courses/course_screen.dart';
import 'package:internshala/feature/main_app/presentation/screens/home/home_screen.dart';
import 'package:internshala/feature/main_app/presentation/screens/internship/internship_screen.dart';
import 'package:internshala/feature/main_app/presentation/screens/jobs/jobs_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/colors.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _screens = [
    const HomeScreen(),
    BlocProvider(
      create: (context) => InternshipBloc()..add(GetInternshipData()),
      child: const InternshipScreen(),
    ),
    const JobsScreen(),
    const ClubsScreen(),
    const CourseScreen()
  ];
  final List<String> _screen_name = const [
    "Home",
    "Internship",
    "Jobs",
    "Clubs",
    "Courses"
  ];
  int _screenIndex = 0;
  Future openUrl(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 42,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: _openDrawer,
          child: SvgPicture.asset(
            AppIcons.menu_icon,
            fit: BoxFit.none,
          ),
        ),
        title: UtilFun.fredokaText(_screen_name[_screenIndex],
            size: 20, fontWeight: FontWeight.bold),
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
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _scaffoldKey.currentState?.closeDrawer();
                    },
                    child: Icon(
                      Icons.clear,
                      color: AppColors.pure_black,
                    ),
                  )
                ],
              ),
              UtilFun.vbox(mediaQuery.height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UtilFun.fredokaText("Hemant Prajapati",
                          size: 16, fontWeight: FontWeight.bold),
                      UtilFun.fredokaText("hemantkumarceo001@gmail.com",
                          size: 14, color: AppColors.black_shade_2)
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.width * .01,
                        vertical: mediaQuery.height * .005),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.black_shade_3)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        UtilFun.hbox(mediaQuery.width * .02),
                        UtilFun.fredokaText("4 >",
                            size: 14, color: AppColors.pure_black),
                      ],
                    ),
                  )
                ],
              ),
              UtilFun.vbox(mediaQuery.height * .03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.settings),
                      ),
                      UtilFun.fredokaText("Preferences", size: 15)
                    ],
                  ),
                  Column(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.edit_document),
                      ),
                      UtilFun.fredokaText("Resume", size: 15)
                    ],
                  ),
                  Column(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        child: Icon(Icons.copy),
                      ),
                      UtilFun.fredokaText("Applications", size: 15)
                    ],
                  ),
                ],
              ),
              UtilFun.vbox(mediaQuery.height * .01),
              Divider(
                color: AppColors.black_shade_3,
              ),
              UtilFun.vbox(mediaQuery.height * .01),
              UtilFun.fredokaText("EXPLORE",
                  color: AppColors.black_shade_2, size: 16),
              UtilFun.vbox(mediaQuery.height * .01),
              DrawerItemWidget(
                title: 'Internships',
                img_url: AppIcons.bottom_nav_internship_selected,
                mediaQuery: mediaQuery,
              ),
              DrawerItemWidget(
                title: 'Jobs',
                img_url: AppIcons.bottom_nav_job_selected,
                mediaQuery: mediaQuery,
              ),
              DrawerItemWidget(
                title: 'Courses',
                img_url: AppIcons.bottom_nav_courses,
                mediaQuery: mediaQuery,
              ),
              DrawerItemWidget(
                title: 'Placement Guarantee Courses',
                img_url: AppIcons.bottom_nav_job_unselected,
                mediaQuery: mediaQuery,
              ),
              DrawerItemWidget(
                title: 'Study Abroad',
                img_url: AppIcons.globe_icon,
                mediaQuery: mediaQuery,
              ),
              DrawerItemWidget(
                title: 'Online Degree',
                img_url: AppIcons.online_degree_icon,
                mediaQuery: mediaQuery,
              ),
              UtilFun.vbox(mediaQuery.height * .02),
              UtilFun.fredokaText("HELP & SUPPORT",
                  color: AppColors.black_shade_2, size: 16),
              UtilFun.vbox(mediaQuery.height * .02),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: mediaQuery.height * .0125),
                child: Row(
                  children: [
                    Icon(
                      Icons.help_outline_rounded,
                      color: AppColors.black_shade_2,
                    ),
                    UtilFun.hbox(mediaQuery.width * .03),
                    Expanded(
                        child: UtilFun.fredokaText("Help Center", size: 18))
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: mediaQuery.height * .0125),
                child: Row(
                  children: [
                    Icon(
                      Icons.report_gmailerrorred_rounded,
                      color: AppColors.black_shade_2,
                    ),
                    UtilFun.hbox(mediaQuery.width * .03),
                    Expanded(
                        child:
                            UtilFun.fredokaText("Report a Complaint", size: 18))
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: mediaQuery.height * .0125),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_box_outlined,
                      color: AppColors.black_shade_2,
                    ),
                    UtilFun.hbox(mediaQuery.width * .03),
                    Expanded(child: UtilFun.fredokaText("More", size: 18))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: _screens[_screenIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(.2),
            blurRadius: 1,
          )
        ]),
        child: BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (value) {
              setState(() {
                _screenIndex = value;
                if (_screenIndex == 3) {
                  openUrl("https://clubs.internshala.com/");
                }
                if (_screenIndex == 4) {
                  openUrl(
                      "https://trainings.internshala.com/?tracking_source=ist_header_logo");
                }
              });
            },
            currentIndex: _screenIndex,
            type: BottomNavigationBarType.fixed,
            elevation: 4,
            selectedLabelStyle:
                const TextStyle(fontFamily: 'Fredoka', fontSize: 12),
            unselectedLabelStyle:
                const TextStyle(fontFamily: 'Fredoka', fontSize: 12),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _screenIndex == 0
                        ? AppIcons.bottom_nav_home_selected
                        : AppIcons.bottom_nav_home_unselected,
                    color: _screenIndex == 0
                        ? AppColors.main_blue
                        : AppColors.black_shade_3,
                    height: 26,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _screenIndex == 1
                        ? AppIcons.bottom_nav_internship_selected
                        : AppIcons.bottom_nav_internship_unselected,
                    color: _screenIndex == 1
                        ? AppColors.main_blue
                        : AppColors.black_shade_3,
                    height: 26,
                  ),
                  label: 'Internship'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    _screenIndex == 2
                        ? AppIcons.bottom_nav_job_selected
                        : AppIcons.bottom_nav_job_unselected,
                    color: _screenIndex == 2
                        ? AppColors.main_blue
                        : AppColors.black_shade_3,
                    height: 26,
                  ),
                  label: 'Jobs'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.bottom_nav_clubs,
                    color: _screenIndex == 3
                        ? AppColors.main_blue
                        : AppColors.black_shade_3,
                    height: 26,
                  ),
                  label: 'Clubs'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.bottom_nav_courses,
                    color: _screenIndex == 4
                        ? AppColors.main_blue
                        : AppColors.black_shade_3,
                    height: 26,
                  ),
                  label: 'Courses'),
            ]),
      ),
    );
  }
}

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget({
    super.key,
    required this.title,
    required this.img_url,
    required this.mediaQuery,
  });

  final Size mediaQuery;
  final String title;
  final String img_url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UtilFun.showSnackbar(context, title, false);
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mediaQuery.height * .0125),
        child: Row(
          children: [
            SvgPicture.asset(
              img_url,
              height: 18,
            ),
            UtilFun.hbox(mediaQuery.width * .03),
            Expanded(child: UtilFun.fredokaText(title, size: 18))
          ],
        ),
      ),
    );
  }
}
