import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitat_ft_admin/model/workshop_model.dart';
import 'package:habitat_ft_admin/repository/workshop_repository.dart';

class AddWorkshopBloc extends Bloc<AddWorkshopEvent, AddWorkshopState> {
  final WorkshopRepository _workshopRepository = WorkshopRepository();
  StreamSubscription _workshopSubscription;

  AddWorkshopBloc(AddWorkshopState initialState) : super(initialState);

  // @override
  // AddWorkshopState get initialState => AddWorkshopInitial();

  @override
  Stream<AddWorkshopState> mapEventToState(
    AddWorkshopEvent event,
  ) async* {
    if (event is AddWorkshopStarted) {
      yield* _mapAddWorkshopStartedToState(event.workshop);
    }
  }

  Stream<AddWorkshopState> _mapAddWorkshopStartedToState(
      Workshop workshop) async* {
    try {
      yield AddWorkshopInProcess();
      _workshopRepository.add(workshop);
      yield AddWorkshopSuccess();
    } catch (e) {
      yield AddWorkshopFailure();
    }
  }

  @override
  Future<void> close() {
    _workshopSubscription?.cancel();
    return super.close();
  }
}

/// EVENT
abstract class AddWorkshopEvent extends Equatable {
  const AddWorkshopEvent();
}

class AddWorkshopStarted extends AddWorkshopEvent {
  final Workshop workshop;

  AddWorkshopStarted(this.workshop);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'AddWorkshopStarted {workshop: ${workshop.toString()}}';
}

/// STATE

abstract class AddWorkshopState extends Equatable {
  const AddWorkshopState();
}

class AddWorkshopInitial extends AddWorkshopState {
  @override
  List<Object> get props => [];
}

class AddWorkshopInProcess extends AddWorkshopState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AddWorkshopInProcess {}';
}

class AddWorkshopSuccess extends AddWorkshopState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AddWorkshopSuccess {}';
}

class AddWorkshopFailure extends AddWorkshopState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AddWorkshopFailure {}';
}
