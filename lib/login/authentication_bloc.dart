import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:habitat_ft_admin/repository/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRespository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRespository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState(event.email, event.password);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState(
      String email, String password) async* {
    try {
      yield AuthenticationInProcess();
      await _userRespository.signInWithEmailAndPassword(email, password);
      yield AuthenticationSuccess();
    } catch (e) {
      print(e);
      yield AuthenticationFailure();
    }
  }
}

///****** EVENT *******/

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationStarted extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationStarted(this.email, this.password);

  @override
  List<Object> get props => [this.email, this.password];

  String toString() => 'AuthenticationStarted { $email and $password }';
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  String toString() => 'AuthenticationLoggedIn { }';
}

class AuthenticationLoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  String toString() => 'AuthenticationLoggedOut { }';
}

///****** STATE *******/

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationInProcess extends AuthenticationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationInProcess { }';
}

class AuthenticationSuccess extends AuthenticationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationSuccess { }';
}

class AuthenticationFailure extends AuthenticationState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationFailure { }';
}
