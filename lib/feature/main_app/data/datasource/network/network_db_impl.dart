import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:internshala/core/constants.dart';
import 'package:internshala/core/errors.dart';
import 'package:internshala/feature/main_app/data/datasource/network/network_db.dart';
import 'package:http/http.dart' as http;
import 'package:internshala/feature/main_app/domain/entities/internship_entity.dart';
import 'package:internshala/feature/main_app/domain/entities/internship_filter_entity.dart';

class NetworkDBImpl extends NetworkDB {
  @override
  Future<Either<CustomError, List<InternshipEntity>>>
      getInternshipData() async {
    List<InternshipEntity> internship_data_list = [];
    try {
      final Dio dio = Dio();
      var response =
          await dio.get("https://internshala.com/flutter_hiring/search");
      var internshipData = jsonDecode(response.data);
      for (int i = 0; i < internshipData['internship_ids'].length; i++) {
        var prefix = internshipData['internships_meta']
            ["${internshipData["internship_ids"][i]}"];
        internship_data_list.add(InternshipEntity(
            title: prefix['title'] ?? "",
            company_name: prefix['company_name'] ?? "",
            start_date: prefix['start_date'] ?? "",
            location_names: prefix["location_names"],
            stipend: prefix['stipend']['salary'] ?? "",
            labels_app: prefix['labels_app'] ?? "",
            duration: prefix['duration'] ?? "",
            posted_by_label: prefix['posted_by_label'] ?? ""));
      }
    } on DioException catch (e) {
      print(e.toString());
      return left(exceptionToError(e));
    } catch (e) {
      print(e.toString());
      return left(exceptionToError(e));
    }

    return right(internship_data_list);
  }

  @override
  Future<Either<CustomError, List<InternshipEntity>>> getInternshipFilterData(
      InternshipFilterEntity internshipFilterEntity) async {
    List<InternshipEntity> internship_data_list = [];
    try {
      final Dio dio = Dio();
      var response =
          await dio.get("https://internshala.com/flutter_hiring/search");
      var internshipData = jsonDecode(response.data);
      List<int> list_profile = [];
      List<int> list_city = [];
      List<int> list_duration = [];
      for (int i = 0; i < internshipData['internship_ids'].length; i++) {
        var prefix = internshipData['internships_meta']
            ["${internshipData["internship_ids"][i]}"];
        internshipFilterEntity.profile_name.forEach((element) {
          if (prefix['profile_name'] ==
              AppConstants.internship_profile_list[element]) {
            list_profile.add(prefix['id']);
          }
        });
        print(internshipFilterEntity.location_names
            .map((e) => AppConstants.cities[e])
            .toList());
        internshipFilterEntity.location_names.forEach((element) {
          if (prefix['location_names'].isNotEmpty) {
            if (prefix['location_names'][0] == AppConstants.cities[element]) {
              print(AppConstants.cities[element]);
              list_city.add(prefix['id']);
            }
          }
        });
        if (internshipFilterEntity.is_duration_selected) {
          if (internshipFilterEntity.duration == prefix['duration']) {
            print("Hua");
            list_duration.add(prefix['id']);
          }
        }
      }

      Set<int> intersection = {};
      print(list_profile.length);
      print(list_duration.length);
      if (list_profile.isNotEmpty) {
        if (intersection.isNotEmpty) {
          intersection = intersection.intersection(list_profile.toSet());
        } else {
          intersection = intersection.union(list_profile.toSet());
        }
      }

      if (list_city.isNotEmpty) {
        if (intersection.isNotEmpty) {
          intersection = intersection.intersection(list_city.toSet());
        } else {
          intersection = intersection.union(list_city.toSet());
        }
      }

      if (list_duration.isNotEmpty) {
        if (intersection.isNotEmpty) {
          intersection = intersection.intersection(list_duration.toSet());
        } else {
          intersection = intersection.union(list_duration.toSet());
        }
      }

      List<int> internships_ids = intersection.toList();
      for (int i = 0; i < internshipData['internship_ids'].length; i++) {
        var prefix = internshipData['internships_meta']
            ["${internshipData["internship_ids"][i]}"];

        if (internships_ids.contains(prefix['id'])) {
          internship_data_list.add(internshipItem(prefix));
        }
      }
      if (internship_data_list.isEmpty) {
        for (int i = 0; i < internshipData['internship_ids'].length; i++) {
          var prefix = internshipData['internships_meta']
              ["${internshipData["internship_ids"][i]}"];

          if (internships_ids.contains(prefix['id'])) {
            internship_data_list.add(internshipItem(prefix));
          }
        }
      }
    } on DioException catch (e) {
      print(e.toString());
      return left(exceptionToError(e));
    } catch (e) {
      print(e.toString());
      return left(exceptionToError(e));
    }

    return right(internship_data_list);
  }

  InternshipEntity internshipItem(prefix) {
    return InternshipEntity(
        title: prefix['title'] ?? "",
        company_name: prefix['company_name'] ?? "",
        start_date: prefix['start_date'] ?? "",
        location_names: prefix["location_names"],
        stipend: prefix['stipend']['salary'] ?? "",
        labels_app: prefix['labels_app'] ?? "",
        duration: prefix['duration'] ?? "",
        posted_by_label: prefix['posted_by_label'] ?? "");
  }
}
