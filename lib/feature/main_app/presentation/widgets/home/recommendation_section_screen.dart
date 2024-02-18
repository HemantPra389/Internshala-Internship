import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:internshala/core/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/util_fun.dart';

class RecommendationSectionScreen extends StatefulWidget {
  const RecommendationSectionScreen({
    super.key,
    required this.mediaQuery,
  });

  final Size mediaQuery;

  @override
  State<RecommendationSectionScreen> createState() =>
      _RecommendationSectionScreenState();
}

class _RecommendationSectionScreenState
    extends State<RecommendationSectionScreen> {
  int recommendation_index = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: widget.mediaQuery.width * .04,
          top: widget.mediaQuery.height * .04,
          bottom: widget.mediaQuery.height * .04),
      color: AppColors.lightest_blue,
      width: widget.mediaQuery.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UtilFun.fredokaText("Recommended for you",
              size: 22, fontWeight: FontWeight.bold),
          Row(
            children: [
              UtilFun.fredokaText("as per your "),
              UtilFun.fredokaText("preferences", color: AppColors.main_blue),
            ],
          ),
          UtilFun.vbox(widget.mediaQuery.height * .04),
          CarouselSlider.builder(
              itemCount: AppConstants.recommended_for_you.length,
              itemBuilder: (context, index, realIndex) => GestureDetector(
                    onTap: () async {
                      await launchUrl(
                          Uri.parse(AppConstants.recommended_for_you[index]
                                  ['job_know_more_link']
                              .toString()),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Container(
                      height: widget.mediaQuery.height * .4,
                      margin:
                          EdgeInsets.only(right: widget.mediaQuery.width * .04),
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.mediaQuery.width * .04,
                          vertical: widget.mediaQuery.height * .04),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.black_shade_3.withOpacity(.1),
                                blurRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: widget.mediaQuery.width * .01,
                                vertical: widget.mediaQuery.height * .001),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        AppColors.main_blue.withOpacity(.3))),
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
                          UtilFun.vbox(widget.mediaQuery.height * .02),
                          UtilFun.fredokaText(
                              AppConstants.recommended_for_you[index]
                                  ['job_title'],
                              fontWeight: FontWeight.bold),
                          UtilFun.vbox(widget.mediaQuery.height * .02),
                          UtilFun.fredokaText(
                              AppConstants.recommended_for_you[index]
                                  ['company_title'],
                              color: AppColors.black_shade_3,
                              size: 16),
                          UtilFun.vbox(widget.mediaQuery.height * .02),
                          Divider(
                            color: AppColors.black_shade_3,
                          ),
                          UtilFun.vbox(widget.mediaQuery.height * .02),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.black_shade_3,
                              ),
                              UtilFun.hbox(8),
                              UtilFun.fredokaText(
                                  AppConstants.recommended_for_you[index]
                                      ['location'],
                                  size: 15)
                            ],
                          ),
                          UtilFun.vbox(widget.mediaQuery.height * .01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.money,
                                color: AppColors.black_shade_3,
                                size: 18,
                              ),
                              UtilFun.hbox(8),
                              UtilFun.fredokaText(
                                  AppConstants.recommended_for_you[index]
                                      ['job_salary'],
                                  size: 15)
                            ],
                          ),
                          Expanded(
                              child: Container(
                            alignment: Alignment.bottomLeft,
                            child: UtilFun.fredokaText("View details >",
                                color: AppColors.main_blue),
                          ))
                        ],
                      ),
                    ),
                  ),
              options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    // setState(() {
                    //   recommendation_index = index;
                    // });
                  },
                  disableCenter: true,
                  height: widget.mediaQuery.height * .4,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  padEnds: false,
                  pauseAutoPlayInFiniteScroll: false,
                  viewportFraction: .8)),
          UtilFun.vbox(widget.mediaQuery.height * .04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSmoothIndicator(
                activeIndex: recommendation_index,
                count: 6,
                effect: ScrollingDotsEffect(
                    activeDotColor: AppColors.main_blue,
                    activeDotScale: 1.4,
                    dotColor: AppColors.black_shade_3.withOpacity(.1),
                    dotHeight: widget.mediaQuery.height * .01,
                    dotWidth: widget.mediaQuery.height * .01),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
