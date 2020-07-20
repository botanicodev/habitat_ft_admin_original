import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitat_ft_admin/model/moment_model.dart';
import 'package:habitat_ft_admin/repository/moment_repository.dart';

class ListMomentBloc extends Bloc<ListMomentEvent, ListMomentState> {
  final String workshopId;
  final MomentRepository _momentsRepository;
  StreamSubscription _momentSubscription;

  ListMomentBloc(this.workshopId)
      : _momentsRepository = MomentRepository(workshopId),
        super(null);

  @override
  Stream<ListMomentState> mapEventToState(
    ListMomentEvent event,
  ) async* {
    if (event is ListMomentStarted) {
      yield* _mapListMomentStartedToState();
    } else if (event is ListMomentLoaded) {
      yield ListMomentSuccess(event.moments);
    }
  }

  Stream<ListMomentState> _mapListMomentStartedToState() async* {
    yield ListMomentInProcess();
    _momentSubscription?.cancel();
    _momentSubscription = _momentsRepository.all().listen(
          (moments) => add(ListMomentLoaded(moments)),
        );
  }

  @override
  Future<void> close() {
    _momentSubscription?.cancel();
    return super.close();
  }
}

/// EVENT
abstract class ListMomentEvent extends Equatable {
  const ListMomentEvent();
}

class ListMomentStarted extends ListMomentEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ListMomentStarted {}';
}

class ListMomentLoaded extends ListMomentEvent {
  final List<Moment> moments;

  ListMomentLoaded(this.moments);

  @override
  List<Object> get props => [moments];

  @override
  String toString() => 'ListMomentLoaded { moments: $moments }';
}

/// STATE

abstract class ListMomentState extends Equatable {
  const ListMomentState();
}

class MomentInitial extends ListMomentState {
  @override
  List<Object> get props => [];
}

class ListMomentInProcess extends ListMomentState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ListMomentInProcess {}';
}

class ListMomentSuccess extends ListMomentState {
  final List<Moment> moments;

  ListMomentSuccess(this.moments);

  @override
  List<Object> get props => [moments];

  @override
  String toString() => 'ListMomentSuccess { moments: $moments}';
}
