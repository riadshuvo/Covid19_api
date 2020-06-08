import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CovidCoromaModelClass {
  final country;
  final lastUpdate;
  final totalConfirmed;
  final todayCases;
  final recovered;
  final todayRecovered;
  final deaths;
  final todayDeaths;
  final critical;
  final totalTasted;
  final active;
  final flag;
  final continent;

  static var formate = new DateFormat.yMMMMd("en_US").add_jm();

  String get getDate => formate
      .format(new DateTime.fromMicrosecondsSinceEpoch(lastUpdate * 1000));

  CovidCoromaModelClass(
      {this.country,
      this.lastUpdate,
      this.totalConfirmed,
      this.todayCases,
      this.recovered,
      this.todayRecovered,
      this.deaths,
      this.todayDeaths,
      this.critical,
      this.totalTasted,
      this.active,
      this.flag,
      this.continent});

  factory CovidCoromaModelClass.fromJson(Map<String, dynamic> json) =>
      CovidCoromaModelClass(
        country: json["country"] == null ? null : json["country"],
        todayCases: json["todayCases"] == null ? 0 : json["todayCases"],
        totalConfirmed: json["cases"] == null ? 0 : json["cases"],
        deaths: json["deaths"] == null ? 0 : json["deaths"],
        todayDeaths: json["todayDeaths"] == null ? 0 : json["todayDeaths"],
        recovered: json["recovered"] == null ? 0 : json["recovered"],
        todayRecovered:
            json["todayRecovered"] == null ? 0 : json["todayRecovered"],
        critical: json["critical"] == null ? 0 : json["critical"],
        totalTasted: json["tests"] == null ? 0 : json["tests"],
        lastUpdate: json["updated"] == null ? 0 : json["updated"],
        active: json["active"] == null ? 0 : json["active"],
        flag: json["countryInfo"]["flag"] == null
            ? null
            : json["countryInfo"]["flag"],
        continent: json["continent"] == null ? null : json["continent"],
      );
}
