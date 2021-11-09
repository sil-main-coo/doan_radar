import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc_delegate.dart';
import 'get_it.dart';
import 'providers/firebase/firebase_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  bool kisweb;
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      kisweb = false;
    } else {
      kisweb = true;
    }
  } catch (e) {
    kisweb = true;
  }

  if (!kisweb) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  setupLocator(); // setup get it : MQTT service
  Bloc.observer = SimpleBlocObserver();
  await locator.get<FirebaseDatabaseHelper>().initial();

  runApp(MyApp());
}

