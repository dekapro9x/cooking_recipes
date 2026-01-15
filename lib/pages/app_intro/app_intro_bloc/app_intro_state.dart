part of 'app_intro_bloc.dart';

class AppIntroState extends Equatable {
  final int currentPage;
  final bool isLastPage;

  const AppIntroState({required this.currentPage, required this.isLastPage});

  AppIntroState copyWith({int? currentPage, bool? isLastPage}) {
    return AppIntroState(
      currentPage: currentPage ?? this.currentPage,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object> get props => [currentPage, isLastPage];
}
