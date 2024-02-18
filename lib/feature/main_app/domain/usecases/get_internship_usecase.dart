import 'package:dartz/dartz.dart';
import 'package:internshala/core/errors.dart';
import 'package:internshala/feature/main_app/domain/entities/internship_entity.dart';
import 'package:internshala/feature/main_app/domain/entities/internship_filter_entity.dart';
import 'package:internshala/feature/main_app/domain/repository/app_repository.dart';

class GetInternshipUseCase {
  final AppRepository appRepository;
  GetInternshipUseCase({required this.appRepository});
  Future<Either<CustomError, List<InternshipEntity>>> getInternshipDataList() {
    return appRepository.getInternshipData();
  }

  Future<Either<CustomError, List<InternshipEntity>>>
      getInternshipFilterDataList(
          InternshipFilterEntity internshipFilterEntity) {
    return appRepository.getInternshipFilterData(internshipFilterEntity);
  }
}
