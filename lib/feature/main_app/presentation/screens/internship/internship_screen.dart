import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internshala/core/colors.dart';
import 'package:internshala/core/util_fun.dart';
import 'package:internshala/feature/main_app/presentation/bloc/internship/bloc/internship_bloc.dart';
import 'package:internshala/feature/main_app/presentation/screens/internship/filter_internship_screen.dart';

import '../../widgets/internship/internship_widget.dart';

class InternshipScreen extends StatefulWidget {
  const InternshipScreen({super.key});

  @override
  State<InternshipScreen> createState() => _InternshipScreenState();
}

class _InternshipScreenState extends State<InternshipScreen> {
  int jobLength = 0;
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<InternshipBloc>(context),
                  child: const FilterInternshipScreen(),
                ),
              )),
              child: Container(
                  height: mediaQuery.height * .04,
                  width: mediaQuery.width * .3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.main_blue),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        color: AppColors.main_blue,
                        size: 16,
                      ),
                      UtilFun.fredokaText("Filters",
                          fontWeight: FontWeight.bold,
                          size: 14,
                          color: AppColors.main_blue)
                    ],
                  )),
            ),
          ],
        ),
        UtilFun.vbox(mediaQuery.height * .01),
        BlocConsumer<InternshipBloc, InternshipState>(
          listener: (context, state) {
            if (state is InternshipListSuccessState) {
              setState(() {
                jobLength = state.internship_data_list.length;
              });
            }
          },
          builder: (context, state) {
            if (state is InternshipListSuccessState) {
              return UtilFun.fredokaText("${jobLength} total internships",
                  size: 14, color: AppColors.black_shade_2);
            } else {
              return UtilFun.fredokaText("Searching.. Internships",
                  size: 14, color: AppColors.black_shade_2);
            }
          },
        ),
        UtilFun.vbox(mediaQuery.height * .02),
        Expanded(
          child: BlocConsumer<InternshipBloc, InternshipState>(
            listener: (context, state) {
              if (state is InternshipListErrorState) {
                UtilFun.showSnackbar(context, state.error);
              }
            },
            builder: (context, state) {
              if (state is InternshipListLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is InternshipListSuccessState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InternshipWidget(
                    mediaQuery: mediaQuery,
                    internshipEntity: state.internship_data_list[index],
                  ),
                  itemCount: state.internship_data_list.length,
                );
              } else {
                return Center(
                  child: Text("Error"),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
