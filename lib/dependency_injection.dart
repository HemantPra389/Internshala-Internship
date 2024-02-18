import 'package:get_it/get_it.dart';
import 'package:internshala/feature/main_app/data/datasource/network/network_db.dart';
import 'package:internshala/feature/main_app/data/datasource/network/network_db_impl.dart';
import 'package:internshala/feature/main_app/data/repository/app_repository_impl.dart';
import 'package:internshala/feature/main_app/domain/repository/app_repository.dart';
import 'package:internshala/feature/main_app/domain/usecases/get_internship_usecase.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton<GetInternshipUseCase>(
      () => GetInternshipUseCase(appRepository: sl()));

  sl.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(networkDB: sl()));
  sl.registerLazySingleton<NetworkDB>(() => NetworkDBImpl());
}
