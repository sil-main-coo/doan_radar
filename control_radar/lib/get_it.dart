import 'package:controlradar/providers/firebase/firebase_helper.dart';
import 'package:controlradar/providers/local/authen_local_provider.dart';
import 'package:controlradar/providers/mqtt/mqtt_service.dart';
import 'package:get_it/get_it.dart';

import 'bloc/app_bloc/app_bloc.dart';
import 'bloc/mqtt_bloc/mqtt_bloc.dart';
import 'bloc/remote_bloc/remote_radar_bloc.dart';
import 'bloc/update_data_bloc/update_data_bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<MQTTService>(() => MQTTService());
  locator.registerLazySingleton<FirebaseDatabaseHelper>(
      () => FirebaseDatabaseHelper());
  locator.registerFactory<AuthenLocalProvider>(() => AuthenLocalProvider());
  locator.registerLazySingleton<AppBloc>(() => AppBloc(locator()));

  locator.registerLazySingleton(() => UpdateDataBloc());
  locator.registerLazySingleton(() => MQTTBloc(locator()));
  locator.registerLazySingleton(() => RemoteRadarBloc());
}
