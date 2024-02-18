part of 'internship_bloc.dart';

sealed class InternshipEvent extends Equatable {
  const InternshipEvent();

  @override
  List<Object> get props => [];
}

class GetInternshipData extends InternshipEvent {}

class GetInternshipFilterData extends InternshipEvent {
  final InternshipFilterEntity internshipFilterEntity;

  GetInternshipFilterData({required this.internshipFilterEntity});
  @override
  List<Object> get props => [internshipFilterEntity];
}
