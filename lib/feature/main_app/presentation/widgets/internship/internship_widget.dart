import 'package:flutter/material.dart';
import 'package:internshala/feature/main_app/domain/entities/internship_entity.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/util_fun.dart';

class InternshipWidget extends StatelessWidget {
  const InternshipWidget({
    super.key,
    required this.internshipEntity,
    required this.mediaQuery,
  });

  final Size mediaQuery;
  final InternshipEntity internshipEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: mediaQuery.height * .45,
      margin: EdgeInsets.only(bottom: mediaQuery.height * .01),
      padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width * .04,
          vertical: mediaQuery.height * .02),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.04),
                blurRadius: 4,
                spreadRadius: 4)
          ],
          border: Border.symmetric(
              horizontal: BorderSide(
                  color: AppColors.black_shade_3.withOpacity(.1), width: 2))),
      width: mediaQuery.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * .01,
                vertical: mediaQuery.height * .001),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.main_blue.withOpacity(.3))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_outward_sharp,
                  color: AppColors.main_blue,
                  size: 16,
                ),
                UtilFun.fredokaText("Actively hiring",
                    size: 14, color: AppColors.black_shade_2),
              ],
            ),
          ),
          // UtilFun.vbox(mediaQuery.height * .01),
          UtilFun.fredokaText(internshipEntity.title,
              size: 24, fontWeight: FontWeight.bold),
          // UtilFun.vbox(mediaQuery.height * .01),
          UtilFun.fredokaText(internshipEntity.company_name,
              size: 18, color: AppColors.black_shade_3),
          // UtilFun.vbox(mediaQuery.height * .02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.black_shade_3,
                size: 16,
              ),
              UtilFun.hbox(8),
              UtilFun.fredokaText(internshipEntity.labels_app,
                  color: AppColors.black_shade_3, size: 16)
            ],
          ),
          // UtilFun.vbox(mediaQuery.height * .02),
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.play_circle_outline_outlined,
                    color: AppColors.black_shade_3,
                    size: 16,
                  ),
                  UtilFun.hbox(8),
                  UtilFun.fredokaText(internshipEntity.start_date,
                      color: AppColors.black_shade_3, size: 16)
                ],
              ),
              UtilFun.hbox(mediaQuery.width * .02),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.alarm,
                    color: AppColors.black_shade_3,
                    size: 16,
                  ),
                  UtilFun.hbox(8),
                  UtilFun.fredokaText(internshipEntity.duration,
                      color: AppColors.black_shade_3, size: 15)
                ],
              ),
            ],
          ),
          // UtilFun.vbox(mediaQuery.height * .02),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.money,
                color: AppColors.black_shade_3,
                size: 16,
              ),
              UtilFun.hbox(8),
              UtilFun.fredokaText(internshipEntity.stipend,
                  color: AppColors.black_shade_3, size: 16)
            ],
          ),
          // UtilFun.vbox(mediaQuery.height * .02),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4)),
            child: UtilFun.fredokaText(internshipEntity.labels_app,
                size: 14, color: AppColors.black_shade_3),
          ),
          // UtilFun.vbox(mediaQuery.height * .02),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4)),
            child: UtilFun.fredokaText(internshipEntity.posted_by_label,
                size: 14, color: AppColors.black_shade_3),
          ),
          // UtilFun.vbox(mediaQuery.height * .02),
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              UtilFun.fredokaText("View details",
                  color: AppColors.main_blue, fontWeight: FontWeight.bold),
              UtilFun.hbox(mediaQuery.width * .04),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaQuery.width * .06,
                    vertical: mediaQuery.height * .01),
                decoration: BoxDecoration(
                    color: AppColors.main_blue,
                    borderRadius: BorderRadius.circular(4)),
                child: UtilFun.fredokaText("Apply now", color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
