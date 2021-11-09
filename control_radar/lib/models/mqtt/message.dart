import 'package:controlradar/constants/mqtt_topic.dart';
import 'package:equatable/equatable.dart';
import 'package:mqtt_client/mqtt_client.dart';

class Message extends Equatable {
  String mess;
  String topic;
  MqttQos qos;

  Message({
    this.mess,
    this.topic,
    this.qos = MqttQos.atMostOnce,
  });

  Message.remote({
    this.mess,
    this.qos = MqttQos.atMostOnce,
  }) {
    this.topic = MqttTopicConstant.remoteTopic;
  }

  @override
  List<Object> get props => [topic, qos, mess];

  @override
  bool get stringify => true;
}
