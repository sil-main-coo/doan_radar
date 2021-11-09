import 'package:controlradar/bloc/mqtt_bloc/bloc.dart';
import 'package:controlradar/bloc/mqtt_bloc/mqtt_bloc.dart';
import 'package:controlradar/constants/mqtt_topic.dart';
import 'package:controlradar/models/mqtt/message.dart';
import 'package:controlradar/radar_widget/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlRadarWidget extends StatelessWidget {
  const ControlRadarWidget({Key key}) : super(key: key);

  void sendMessage(MQTTBloc mqttBloc, String msg) {
    mqttBloc.add(SendMessage(message: Message.remote(mess: msg)));
  }

  @override
  Widget build(BuildContext context) {
    final mqttBloc = BlocProvider.of<MQTTBloc>(context);

    return Expanded(
      child: Row(
        children: [
          AppButton(
              label: "Quét",
              callback: () {
                print('auto');
                sendMessage(mqttBloc, MqttTopicConstant.QUAY);
              }),
          AppButton(
              label: "Dừng",
              callback: () {
                print('auto');
                sendMessage(mqttBloc, MqttTopicConstant.DUNG);
              }),
          AppButton(
              label: "Tiến",
              callback: () {
                print('auto');
                sendMessage(mqttBloc, MqttTopicConstant.TIEN);
              }),
          AppButton(
              label: "Lùi",
              callback: () {
                print('auto');
                sendMessage(mqttBloc, MqttTopicConstant.LUI);
              }),
          AppButton(
              label: "Trái",
              callback: () {
                print('auto');
                sendMessage(mqttBloc, MqttTopicConstant.TRAI);
              }),
          AppButton(
              label: "Phải",
              callback: () {
                print('auto');
                sendMessage(mqttBloc, MqttTopicConstant.PHAI);
              }),
          AppButton(
              label: "Stop",
              callback: () {
                print('auto');
                sendMessage(mqttBloc, MqttTopicConstant.STOP);
              }),
        ],
      ),
    );
  }
}
