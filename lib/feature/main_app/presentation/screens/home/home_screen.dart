import 'package:flutter/material.dart';

import '../../widgets/home/certification_section_screen.dart';
import '../../widgets/home/placement_section_screen.dart';
import '../../widgets/home/recommendation_section_screen.dart';
import '../../widgets/home/trending_section_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          TrendingSectionScreen(mediaQuery: mediaQuery),
          RecommendationSectionScreen(mediaQuery: mediaQuery),
          CertificationSectionScreen(mediaQuery: mediaQuery),
          PlacementSectionScreen(mediaQuery: mediaQuery)
        ],
      ),
    );
  }
}
