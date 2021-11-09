import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc/app_bloc/bloc.dart';
import 'bloc/mqtt_bloc/bloc.dart';
import 'bloc/mqtt_bloc/mqtt_bloc.dart';
import 'bloc/remote_bloc/remote_radar_bloc.dart';
import 'bloc/update_data_bloc/update_data_bloc.dart';
import 'get_it.dart';
import 'login/bloc/bloc.dart';
import 'login/login.dart';
import 'providers/local/authen_local_provider.dart';
import 'radar_widget/radar_page.dart';
import 'radar_widget/widgets/loading_dialog.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
              create: (context) => locator<AppBloc>()
                ..add(
                  AppStarted(),
                )),
          BlocProvider<LoginBloc>(
            create: (context) {
              return LoginBloc(
                  appBloc: locator<AppBloc>(),
                  authenLocalProvider: locator<AuthenLocalProvider>());
            },
          ),
          BlocProvider<UpdateDataBloc>(
              create: (context) => locator<UpdateDataBloc>()),
          BlocProvider<RemoteRadarBloc>(
              create: (context) => locator<RemoteRadarBloc>()),
          BlocProvider<MQTTBloc>(
              create: (context) =>
                  locator<MQTTBloc>()..add(ConnectMQTTService())),
        ],
        child: ScreenUtilInit(
          designSize: Size(1364, 697),
          builder: () => MaterialApp(
            title: 'Control Radar',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Scaffold(
              body: BlocConsumer<AppBloc, AppState>(
                listener: (context, state) {
                  if (state is AppLoading) {
                    LoadingDialog.show(context);
                  } else if (state is HideAppLoading) {
                    LoadingDialog.hide(context);
                  }
                },
                builder: (context, state) {
                  if (state is AppAuthenticated) {
                    return _buildHome();
                  }
                  if (state is AppUnauthenticated) {
                    return LoginPage();
                  }
                  return Scaffold(
                    body: Center(
                      child: const CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHome() {
    return BlocBuilder<MQTTBloc, MQTTState>(
      builder: (context, state) {
        if (state is ConnectedMQTT) {
          return RadarPage();
        }
        if (state is ConnectMQTTFailedState)
          return Text(
            'Lỗi',
            style: TextStyle(fontSize: 30, color: Colors.red),
          );
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
