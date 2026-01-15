import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_intro_state.dart';

class AppIntroBloc extends Bloc<AppIntroEvent, AppIntroState> {
  static const int totalPages = 4;

  AppIntroBloc()
    : super(const AppIntroState(currentPage: 0, isLastPage: false)) {
    on<NextPageEvent>(_onNextPage);
    on<SkipToHomeEvent>(_onSkipToHome);
    on<PageChangedEvent>(_onPageChanged);
  }

  void _onNextPage(NextPageEvent event, Emitter<AppIntroState> emit) {
    final nextPage = state.currentPage + 1;
    final isLast = nextPage >= totalPages - 1;

    if (nextPage < totalPages) {
      emit(state.copyWith(currentPage: nextPage, isLastPage: isLast));
    }
  }

  void _onSkipToHome(SkipToHomeEvent event, Emitter<AppIntroState> emit) {
    emit(state.copyWith(currentPage: totalPages - 1, isLastPage: true));
  }

  void _onPageChanged(PageChangedEvent event, Emitter<AppIntroState> emit) {
    final isLast = event.pageIndex >= totalPages - 1;
    emit(state.copyWith(currentPage: event.pageIndex, isLastPage: isLast));
  }
}

abstract class AppIntroEvent extends Equatable {
  const AppIntroEvent();

  @override
  List<Object> get props => [];
}

class NextPageEvent extends AppIntroEvent {}

class SkipToHomeEvent extends AppIntroEvent {}

class PageChangedEvent extends AppIntroEvent {
  final int pageIndex;

  const PageChangedEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}
