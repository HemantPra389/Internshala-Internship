class InternshipFilterEntity {
  List<int> profile_name;
  List<int> location_names;
  String duration;
  bool is_duration_selected;

  InternshipFilterEntity({
    required this.profile_name,
    required this.location_names,
    required this.duration,
    required this.is_duration_selected
  });
}
