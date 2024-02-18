import 'dart:convert';

import 'package:flutter/foundation.dart';

class InternshipEntity {
  String title;
  String company_name;
  String start_date;
  List<dynamic> location_names;
  String stipend;
  String labels_app;
  String posted_by_label;
  String duration;

  InternshipEntity(
      {required this.title,
      required this.company_name,
      required this.start_date,
      required this.location_names,
      required this.stipend,
      required this.labels_app,
      required this.posted_by_label,
      required this.duration});
}
