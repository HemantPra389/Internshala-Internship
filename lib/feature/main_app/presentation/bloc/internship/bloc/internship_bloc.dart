import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internshala/dependency_injection.dart';
import 'package:internshala/feature/main_app/domain/entities/internship_entity.dart';
import 'package:internshala/feature/main_app/domain/entities/internship_filter_entity.dart';
import 'package:internshala/feature/main_app/domain/usecases/get_internship_usecase.dart';

part 'internship_event.dart';
part 'internship_state.dart';

class InternshipBloc extends Bloc<InternshipEvent, InternshipState> {
  InternshipBloc() : super(InternshipInitial()) {
    on<GetInternshipData>((event, emit) async {
      try {
        emit(InternshipListLoadingState());
        final res =
            await sl.call<GetInternshipUseCase>().getInternshipDataList();
        res.fold(
            (error) => emit(InternshipListErrorState(error: error.message)),
            (internship_data_list) => emit(InternshipListSuccessState(
                internship_data_list: internship_data_list)));
      } catch (e) {
        emit(InternshipListErrorState(error: e.toString()));
      }
    });
    on<GetInternshipFilterData>((event, emit) async {
      try {
        emit(InternshipListLoadingState());
        print("Clicked");
        final res = await sl
            .call<GetInternshipUseCase>()
            .getInternshipFilterDataList(event.internshipFilterEntity);
        res.fold(
            (error) => emit(InternshipListErrorState(error: error.message)),
            (internship_data_list) {
          print(internship_data_list.length);
          emit(InternshipListSuccessState(
              internship_data_list: internship_data_list));
        });
      } catch (e) {
        emit(InternshipListErrorState(error: e.toString()));
      }
    });
  }
}
