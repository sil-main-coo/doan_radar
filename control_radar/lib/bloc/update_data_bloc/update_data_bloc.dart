import 'dart:math';

import 'package:controlradar/bloc/update_data_bloc/bloc.dart';
import 'package:controlradar/constants/mqtt_topic.dart';
import 'package:controlradar/radar_widget/radar_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// @Singleton
class UpdateDataBloc extends Bloc<UpdateDataEvent, UpdateDataState> {
  List<Offset> _points = [];
  double _radius;
  double _lastRadian = 0.0;
  double _currentRadian = 0.0;

  UpdateDataBloc() : super(LoadingData());

  @override
  Stream<UpdateDataState> mapEventToState(UpdateDataEvent event) async* {
    if (event is InitData) {
      _radius = RadarConstants.radius;
      yield LoadedData(radius: _radius);
    } else if (event is UpdateData) {
      yield* _updateData(event);
    } else if (event is UpdateErrorEvent) {
      yield* _updateError(event);
    }
  }

  Stream<UpdateDataState> _updateData(UpdateData event) async* {
    // yield LoadingState();
    final currentState = state;
    if (currentState is LoadedData) {
      try {
        final mess = event.message.mess;
        if (mess != null && mess.isNotEmpty) {
          final topic = event.message.topic;
          if (topic == MqttTopicConstant.followTopic) {
            debugPrint(event.message.mess);

            final data = event.message.mess.split('#');
            final rActual = double.parse(data[1]);

            _lastRadian = _currentRadian;
            _currentRadian = double.parse(data[0]);

            if (_lastRadian ~/ 6 == 1 && _currentRadian ~/ 1 == 0) {
              _points.clear();
            }

            if (rActual <= 500) {
              /// radius/min(width, height) <=> 500cm
              /// ? <=> r
              final rSimulatorPoint = _radius * rActual / 500;
              final dx = rSimulatorPoint * cos(_currentRadian);
              final dy = rSimulatorPoint * sin(_currentRadian);

              _points.add(Offset(RadarConstants.maxWidthRadius / 2 + dx,
                  RadarConstants.maxHeightRadius / 2 + dy));

              debugPrint(_points.toString());
            }

            yield currentState.copyWith(
                radian: _currentRadian,
                points: _points,
                currentDistance: rActual);
          }
        }
      } catch (e) {
        debugPrint(e);
        yield FailedData();
      }
    }
  }

  Stream<UpdateDataState> _updateError(UpdateErrorEvent event) async* {
    final currentState = state;
    if (currentState is LoadedData) {
      yield currentState.withError(error: event.error);
    }
  }
}
