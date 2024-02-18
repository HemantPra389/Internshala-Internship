import 'package:dartz/dartz.dart';
import 'package:internshala/feature/main_app/domain/entities/internship_filter_entity.dart';

import '../../../../../core/errors.dart';
import '../../../domain/entities/internship_entity.dart';

abstract class NetworkDB {
  Future<Either<CustomError, List<InternshipEntity>>> getInternshipData();
  Future<Either<CustomError, List<InternshipEntity>>> getInternshipFilterData(
      InternshipFilterEntity internshipFilterEntity);
}
