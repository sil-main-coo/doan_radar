import 'package:controlradar/login/bloc/bloc.dart';
import 'package:controlradar/models/account.dart';
import 'package:controlradar/radar_widget/widgets/dialogs.dart';
import 'package:controlradar/radar_widget/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_textfield.dart';

class BoxInputLogin extends StatefulWidget {
  @override
  _BoxInputLoginState createState() => _BoxInputLoginState();
}

class _BoxInputLoginState extends State<BoxInputLogin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _onLoginButtonPressed() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
            account: Account(
          useName: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginLoading) {
        LoadingDialog.show(context);
      } else if (state is LoginFailure) {
        AppDialog.showNotifyDialog(
          context,
          state.error,
        );
      } else if (state is HiddenLoginLoading) {
        LoadingDialog.hide(context);
      }
    }, builder: (context, state) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 32.w,
                  ),
                  Text(
                    'ĐĂNG NHẬP',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline
                        .copyWith(fontSize: 48.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 32.w,
                  ),
                  SizedBox(
                    height: 350.w,
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            AppTextField.tfOnBody(context, _usernameController,
                                'Tài khoản', TextInputAction.next, true),
                            SizedBox(
                              height: ScreenUtil().setHeight(40),
                            ),
                            AppTextField.tfOnBody(context, _passwordController,
                                'Mật khẩu', TextInputAction.done, false,
                                obscureText: true),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),
                  SizedBox(
                      height: 80.w,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () => _onLoginButtonPressed(),
                        child: Text("ĐĂNG NHẬP",
                            style: Theme.of(context)
                                .primaryTextTheme
                                .button
                                .copyWith(
                                  fontSize: ScreenUtil().setSp(48.sp),
                                )),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
