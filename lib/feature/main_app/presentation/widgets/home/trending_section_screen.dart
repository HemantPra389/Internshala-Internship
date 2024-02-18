import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:internshala/core/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/colors.dart';
import '../../../../../core/util_fun.dart';

class TrendingSectionScreen extends StatefulWidget {
  const TrendingSectionScreen({
    super.key,
    required this.mediaQuery,
  });

  final Size mediaQuery;

  @override
  State<TrendingSectionScreen> createState() => _TrendingSectionScreenState();
}

class _TrendingSectionScreenState extends State<TrendingSectionScreen> {
  int banner_index = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.mediaQuery.width * .04,
          top: widget.mediaQuery.height * .05,
          bottom: widget.mediaQuery.height * .05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UtilFun.fredokaText("Hi, Hemant!",
              size: 32, fontWeight: FontWeight.bold),
          UtilFun.vbox(widget.mediaQuery.height * .01),
          UtilFun.fredokaText("Let's help you land your dream career",
              color: AppColors.black_shade_3),
          UtilFun.vbox(widget.mediaQuery.height * .04),
          UtilFun.fredokaText("Trending on Internshala",
              size: 22, fontWeight: FontWeight.bold),
          CarouselSlider.builder(
              itemCount: AppConstants.banners_link.length,
              itemBuilder: (context, index, realIndex) => GestureDetector(
                    onTap: () async {
                      await launchUrl(
                          Uri.parse(AppConstants.banners_link[index]['link']
                              .toString()),
                          mode: LaunchMode.externalApplication);
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: widget.mediaQuery.width * .05),
                      child: Image.asset(
                        "assets/images/${AppConstants.banners_link[index]["banner_id"]}.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
              options: CarouselOptions(
                  height: widget.mediaQuery.height * .35,
                  onPageChanged: (index, reason) {
                    setState(() {
                      banner_index = index;
                    });
                  },
                  aspectRatio: 14 / 9,
                  enableInfiniteScroll: false,
                  pauseAutoPlayInFiniteScroll: false,
                  viewportFraction: 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSmoothIndicator(
                activeIndex: banner_index,
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
