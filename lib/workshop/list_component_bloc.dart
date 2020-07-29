import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitat_ft_admin/model/component/component.dart';
import 'package:habitat_ft_admin/repository/component_repository.dart';

class ListComponentBloc extends Bloc<ListComponentEvent, ListComponentState> {
  final String workshopId;
  final String momentId;

  final ComponentRepository _repository;
  StreamSubscription _subscription;

  ListComponentBloc(this.workshopId, this.momentId)
      : _repository = ComponentRepository(workshopId, momentId),
        super(null);

  @override
  Stream<ListComponentState> mapEventToState(
    ListComponentEvent event,
  ) async* {
    if (event is ListComponentStarted) {
      yield* _mapListComponentStartedToState();
    } else if (event is ListComponentLoaded) {
      yield ListComponentSuccess(components: event.components);
    }
  }

  Stream<ListComponentState> _mapListComponentStartedToState() async* {
    yield ListComponentInProcess();
    _subscription?.cancel();
    _subscription = _repository.all().listen(
          (components) => add(ListComponentLoaded(components: components)),
        );
  }
}

/// EVENT
abstract class ListComponentEvent extends Equatable {
  const ListComponentEvent();
}

class ListComponentStarted extends ListComponentEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ListComponentStarted {}';
}

class ListComponentLoaded extends ListComponentEvent {
  final List<Component> components;

  ListComponentLoaded({this.components});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'ListComponentLoaded { components: $components }';
}

/// STATE
abstract class ListComponentState extends Equatable {
  const ListComponentState();
}

class ComponentInitial extends ListComponentState {
  @override
  List<Object> get props => [];
}

class ListComponentInProcess extends ListComponentState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ListComponentInProcess {}';
}

class ListComponentSuccess extends ListComponentState {
  final List<Component> components;

  ListComponentSuccess({@required this.components});
  @override
  List<Object> get props => [this.components];

  @override
  String toString() => 'ListComponentSuccess {}';
}
