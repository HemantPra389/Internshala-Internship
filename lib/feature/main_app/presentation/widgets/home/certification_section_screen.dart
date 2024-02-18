import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:internshala/core/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/util_fun.dart';

class CertificationSectionScreen extends StatefulWidget {
  const CertificationSectionScreen({
    super.key,
    required this.mediaQuery,
  });

  final Size mediaQuery;

  @override
  State<CertificationSectionScreen> createState() =>
      _CertificationSectionScreenState();
}

class _CertificationSectionScreenState
    extends State<CertificationSectionScreen> {
  int certification_index = 0;
  List<Map<String, dynamic>> certification_list =
      AppConstants.certification_map;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: widget.mediaQuery.width * .04,
          top: widget.mediaQuery.height * .04,
          bottom: widget.mediaQuery.height * .04),
      width: widget.mediaQuery.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UtilFun.fredokaText("Popular certification courses",
              size: 22, fontWeight: FontWeight.bold),
          UtilFun.vbox(widget.mediaQuery.height * .02),
          CarouselSlider.builder(
              itemCount: certification_list.length,
              itemBuilder: (context, index, realIndex) => GestureDetector(
                    onTap: () async {
                      
                    },
                    child: Container(
                      width: widget.mediaQuery.width * .5,
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
                              imageUrl: certification_list[index]['image_link'],
                            ),
                          ),
                          UtilFun.vbox(widget.mediaQuery.height * .01),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UtilFun.fredokaText(
                                    certification_list[index]['duration'],
                                    size: 14,
                                    color: AppColors.black_shade_3),
                                UtilFun.vbox(widget.mediaQuery.height * .01),
                                UtilFun.fredokaText(
                                    certification_list[index]['course'],
                                    fontWeight: FontWeight.bold),
                                UtilFun.vbox(widget.mediaQuery.height * .01),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      UtilFun.hbox(
                                          widget.mediaQuery.width * .02),
                                      UtilFun.fredokaText(
                                          certification_list[index]['rating'],
                                          size: 14,
                                          color: AppColors.black_shade_3),
                                      UtilFun.hbox(
                                          widget.mediaQuery.width * .02),
                                      VerticalDivider(
                                        thickness: 1,
                                        color: AppColors.black_shade_3,
                                      ),
                                      UtilFun.hbox(
                                          widget.mediaQuery.width * .02),
                                      UtilFun.fredokaText(
                                          certification_list[index]
                                              ['purchased_count'],
                                          size: 14,
                                          color: AppColors.black_shade_3),
                                    ],
                                  ),
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
                      certification_index = index;
                    });
                  },
                  disableCenter: true,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  padEnds: false,
                  pauseAutoPlayInFiniteScroll: false,
                  viewportFraction: .6)),
          UtilFun.vbox(widget.mediaQuery.height * .04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSmoothIndicator(
                activeIndex: certification_index,
                count: certification_list.length,
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
