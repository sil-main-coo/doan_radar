import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:controlradar/bloc/app_bloc/bloc.dart';
import 'package:controlradar/login/bloc/bloc.dart';
import 'package:controlradar/providers/local/authen_local_provider.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppBloc appBloc;
  final AuthenLocalProvider authenLocalProvider;

  LoginBloc({this.appBloc, this.authenLocalProvider}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await authenLocalProvider.getTokenFromLocal();

        final isSuccess = event.account.useName == 'admin' &&
            event.account.password == 'admin';

        if (!isSuccess) {
          yield HiddenLoginLoading();
          yield LoginFailure(error: 'Sai thông tin tài khoản');
        } else {
          final token = 'token'; // -> lưu token
          appBloc.add(LoggedIn(token: token));
          yield HiddenLoginLoading();
          yield LoginInitial();
        }
      } catch (error) {
        yield HiddenLoginLoading();
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
