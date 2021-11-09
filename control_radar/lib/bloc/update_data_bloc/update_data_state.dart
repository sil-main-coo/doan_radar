import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UpdateDataState extends Equatable {
  const UpdateDataState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadingData extends UpdateDataState {}

class ShowDialogDataState extends UpdateDataState {}

class LoadedData extends UpdateDataState {
  final double radian;
  final double radius;
  final List<Offset> points;
  final bool isChange;
  final String error;
  final double currentDistance;

  String get angle => this.radian > 2 * pi
      ? (this.radian * 1 / (2 * pi)).toStringAsFixed(2)
      : (this.radian * 180 / pi).toStringAsFixed(2);

  const LoadedData(
      {this.radian = .0,
      this.currentDistance = .0,
      @required this.radius,
      this.points = const [],
      this.isChange = true,
      this.error});

  LoadedData copyWith(
      {double radian,
      double radius,
      double currentDistance,
      List<Offset> points}) {
    return LoadedData(
        radian: radian ?? this.radian,
        radius: radius ?? this.radius,
        isChange: !this.isChange,
        points: points ?? this.points,
        currentDistance: currentDistance ?? this.currentDistance,
        error: null);
  }

  LoadedData withError({@required String error}) {
    return LoadedData(
        radian: this.radian,
        radius: this.radius,
        isChange: !this.isChange,
        points: this.points,
        currentDistance: this.currentDistance,
        error: error);
  }

  @override
  List<Object> get props =>
      [radian, isChange, points, radius, error, currentDistance];
}

class FailedData extends UpdateDataState {
  final Exception error;

  FailedData({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FailedData { error: $error }';
}

class RemoteSuccess extends UpdateDataState {}
