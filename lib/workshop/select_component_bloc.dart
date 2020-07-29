import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitat_ft_admin/repository/workshop_repository.dart';

class SelectComponentBloc
    extends Bloc<SelectComponentEvent, SelectComponentState> {
  final WorkshopRepository _workshopRepository = WorkshopRepository();
  StreamSubscription _workshopSubscription;

  SelectComponentBloc() : super(null);

  @override
  Stream<SelectComponentState> mapEventToState(
    SelectComponentEvent event,
  ) async* {
    if (event is SelectComponentStarted) {
      yield* _mapAddWorkshopStartedToState(event.componentType);
    }
  }

  Stream<SelectComponentState> _mapAddWorkshopStartedToState(
      String componentType) async* {
    if (componentType == 'video') {
      yield SelectedComponentVideo();
    } else if (componentType == 'audio') {
      yield SelectedComponentAudio();
    } else if (componentType == 'document') {
      yield SelectedComponentDocument();
    } else if (componentType == 'image') {
      yield SelectedComponentImage();
    }
  }

  @override
  Future<void> close() {
    _workshopSubscription?.cancel();
    return super.close();
  }
}

/// EVENT
abstract class SelectComponentEvent extends Equatable {
  const SelectComponentEvent();
}

class SelectComponentStarted extends SelectComponentEvent {
  final String componentType;

  SelectComponentStarted(this.componentType);

  @override
  List<Object> get props => [];

  @override
  String toString() => 'SelectComponentEvent {}';
}

/// STATE

abstract class SelectComponentState extends Equatable {
  const SelectComponentState();
}

class AddWorkshopInitial extends SelectComponentState {
  @override
  List<Object> get props => [];
}

class SelectedComponentVideo extends SelectComponentState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SelectedComponentVideo {}';
}

class SelectedComponentAudio extends SelectComponentState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SelectedComponentAudio {}';
}

class SelectedComponentImage extends SelectComponentState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SelectedComponentImage {}';
}

class SelectedComponentDocument extends SelectComponentState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'SelectedComponentDocument {}';
}
