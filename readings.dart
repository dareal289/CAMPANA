import 'package:flutter/material.dart';

class Reading {
  final int? id;
  final double? temperature, humidity;
  final String? reading_time;

  Reading({this.id, this.temperature, this.humidity, this.reading_time});

  factory Reading.fromJson(Map<String, dynamic> json) {
    double convertedTemperature = double.parse(json['temperature']);
    double convertedHumidity = double.parse(json['humidity']);
    return Reading(
      id: json['id'],
      temperature: convertedTemperature,
      humidity: convertedHumidity,
      reading_time: json['reading_time'],
    );
  }
}