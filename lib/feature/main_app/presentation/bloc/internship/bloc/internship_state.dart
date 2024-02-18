part of 'internship_bloc.dart';

sealed class InternshipState extends Equatable {
  const InternshipState();

  @override
  List<Object> get props => [];
}

final class InternshipInitial extends InternshipState {}

class InternshipListLoadingState extends InternshipState {}

class InternshipListErrorState extends InternshipState {
  final String error;

  const InternshipListErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class InternshipListSuccessState extends InternshipState {
  final List<InternshipEntity> internship_data_list;

  const InternshipListSuccessState({required this.internship_data_list});
  @override
  List<Object> get props => [internship_data_list];
}
