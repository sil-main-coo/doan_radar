
import 'package:controlradar/models/account.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final Account account;

  const LoginButtonPressed({
    this.account,
  });

  @override
  List<Object> get props => [account];

  @override
  String toString() =>
      'LoginButtonPressed { username: ${account.useName}, password: ${account.password} }';
}

class Logout extends LoginEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}