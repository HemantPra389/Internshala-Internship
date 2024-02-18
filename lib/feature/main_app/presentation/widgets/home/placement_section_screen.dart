import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:internshala/core/colors.dart';
import 'package:internshala/core/constants.dart';
import 'package:internshala/core/util_fun.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class PlacementSectionScreen extends StatefulWidget {
  const PlacementSectionScreen({
    Key? key,
    required this.mediaQuery,
  }) : super(key: key);

  final Size mediaQuery;

  @override
  State<PlacementSectionScreen> createState() => _PlacementSectionScreenState();
}

class _PlacementSectionScreenState extends State<PlacementSectionScreen> {
  int placement_index = 0;
  List<Map<String, dynamic>> placement_map = AppConstants.placement_course_map;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: widget.mediaQuery.width * .04,
          bottom: widget.mediaQuery.height * .04),
      width: widget.mediaQuery.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UtilFun.fredokaText("Placement guarantee courses",
              size: 22, fontWeight: FontWeight.bold),
          UtilFun.vbox(widget.mediaQuery.height * .02),
          CarouselSlider.builder(
              itemCount: placement_map.length,
              itemBuilder: (context, index, realIndex) => GestureDetector(
                    onTap: () async {
                      await launchUrl(
                          Uri.parse(
                              placement_map[index]['banner_link'].toString()),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Container(
                      width: widget.mediaQuery.width * .55,
                      padding: EdgeInsets.only(
                          bottom: widget.mediaQuery.width * .02),
                      margin:
                          EdgeInsets.only(right: widget.mediaQuery.width * .04),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.black_shade_3.withOpacity(.1)),
                          borderRadius: BorderRadius.circular(
                              widget.mediaQuery.width * .02)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    widget.mediaQuery.width * .02),
                                topRight: Radius.circular(
                                    widget.mediaQuery.width * .02)),
                            child: CachedNetworkImage(
                              imageUrl: placement_map[index]['image_link'],
                            ),
                          ),
                          UtilFun.vbox(widget.mediaQuery.height * .03),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UtilFun.fredokaText(
                                    placement_map[index]['title'],
                                    fontWeight: FontWeight.bold),
                                UtilFun.vbox(widget.mediaQuery.height * .01),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.amber.shade200),
                                  child: UtilFun.fredokaText(
                                      "courses with guaranteed internship",
                                      size: 14),
                                ),
                                UtilFun.vbox(widget.mediaQuery.height * .01),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.alarm,
                                      color: AppColors.black_shade_3,
                                      size: 16,
                                    ),
                                    UtilFun.hbox(8),
                                    Expanded(
                                      child: UtilFun.fredokaText(
                                          placement_map[index]['duration'],
                                          color: AppColors.black_shade_3,
                                          size: 15),
                                    ),
                                  ],
                                ),
                                UtilFun.vbox(widget.mediaQuery.height * .02),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    UtilFun.fredokaText("₹"),
                                    UtilFun.hbox(6),
                                    Expanded(
                                      child: UtilFun.fredokaText(
                                          placement_map[index]['salary'],
                                          color: AppColors.black_shade_3,
                                          size: 15),
                                    ),
                                  ],
                                ),
                                UtilFun.vbox(widget.mediaQuery.height * .02),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.badge,
                                      color: AppColors.black_shade_3,
                                      size: 16,
                                    ),
                                    UtilFun.hbox(8),
                                    Expanded(
                                      child: UtilFun.fredokaText(
                                          placement_map[index]['jobs_count'],
                                          color: AppColors.black_shade_3,
                                          size: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.bottomLeft,
                              child: UtilFun.fredokaText("Know more >",
                                  color: AppColors.main_blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      placement_index = index;
                    });
                  },
                  disableCenter: true,
                  initialPage: 0,
                  height: widget.mediaQuery.height * .5,
                  enableInfiniteScroll: false,
                  padEnds: false,
                  pauseAutoPlayInFiniteScroll: false,
                  viewportFraction: .7)),
          UtilFun.vbox(widget.mediaQuery.height * .04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSmoothIndicator(
                activeIndex: placement_index,
                count: placement_map.length,
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
