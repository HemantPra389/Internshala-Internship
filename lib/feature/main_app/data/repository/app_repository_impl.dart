import 'package:dartz/dartz.dart';
import 'package:internshala/core/errors.dart';
import 'package:internshala/feature/main_app/data/datasource/network/network_db.dart';
import 'package:internshala/feature/main_app/domain/entities/internship_entity.dart';
import 'package:internshala/feature/main_app/domain/entities/internship_filter_entity.dart';
import 'package:internshala/feature/main_app/domain/repository/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final NetworkDB networkDB;

  AppRepositoryImpl({required this.networkDB});
  @override
  Future<Either<CustomError, List<InternshipEntity>>> getInternshipData() {
    return networkDB.getInternshipData();
  }

  @override
  Future<Either<CustomError, List<InternshipEntity>>> getInternshipFilterData(
      InternshipFilterEntity internshipFilterEntity) {
    return networkDB.getInternshipFilterData(internshipFilterEntity);
  }
}
