import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitat_ft_admin/model/workshop_model.dart';
import 'package:habitat_ft_admin/repository/workshop_repository.dart';

class ListWorkshopBloc extends Bloc<ListWorkshopEvent, ListWorkshopState> {
  final WorkshopRepository _workshopRepository = WorkshopRepository();
  StreamSubscription _workshopSubscription;

  ListWorkshopBloc(ListWorkshopState initialState) : super(initialState);

  @override
  Stream<ListWorkshopState> mapEventToState(
    ListWorkshopEvent event,
  ) async* {
    if (event is ListWorkshopStarted) {
      yield* _mapListWorkshopStartedToState();
    } else if (event is ListWorkshopLoaded) {
      yield ListWorkshopSuccess(event.workshops);
    }
  }

  Stream<ListWorkshopState> _mapListWorkshopStartedToState() async* {
    yield ListWorkshopInProcess();
    _workshopSubscription?.cancel();
    _workshopRepository.all().listen(
          (workshops) => add(ListWorkshopLoaded(workshops)),
        );
  }
}

/// EVENT
abstract class ListWorkshopEvent extends Equatable {
  const ListWorkshopEvent();
}

class ListWorkshopStarted extends ListWorkshopEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ListWorkshopStarted {}';
}

class ListWorkshopLoaded extends ListWorkshopEvent {
  final List<Workshop> workshops;

  ListWorkshopLoaded(this.workshops);

  @override
  List<Object> get props => [workshops];

  @override
  String toString() => 'ListWorkshopLoaded {workshops: $workshops}';
}

/// STATE
abstract class ListWorkshopState extends Equatable {
  const ListWorkshopState();
}

class ListWorkshopInitial extends ListWorkshopState {
  @override
  List<Object> get props => [];
}

class ListWorkshopInProcess extends ListWorkshopState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ListWorkshopInProcess {}';
}

class ListWorkshopSuccess extends ListWorkshopState {
  final List<Workshop> workshops;

  ListWorkshopSuccess(this.workshops);

  @override
  List<Object> get props => [workshops];

  @override
  String toString() => 'ListWorkshopSuccess { workshops: $workshops}';
}

class ListWorkshopFailure extends ListWorkshopState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ListWorkshopFailure {}';
}

class DeleteWorkshopInProcess extends ListWorkshopState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'DeleteWorkshopInProcess {}';
}
