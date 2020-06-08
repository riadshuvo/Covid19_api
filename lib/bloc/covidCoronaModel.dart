
import 'dart:convert';
import 'package:intl/intl.dart';


class CovidCoromaModelClass{
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

  String get getDate => formate.format(
      new DateTime.fromMicrosecondsSinceEpoch(
          lastUpdate *1000));


  CovidCoromaModelClass({this.country, this.lastUpdate, this.totalConfirmed,
      this.todayCases, this.recovered, this.todayRecovered, this.deaths,
      this.todayDeaths, this.critical, this.totalTasted,this.active,this.flag,this.continent});

  factory CovidCoromaModelClass.fromJson(Map<String, dynamic> json) => CovidCoromaModelClass(
    country: json["country"],
    todayCases: json["todayCases"],
    totalConfirmed: json["cases"],
    deaths: json["deaths"],
    todayDeaths: json["todayDeaths"],
    recovered: json["recovered"],
    todayRecovered: json["todayRecovered"],
    critical: json["critical"],
    totalTasted: json["tests"],
    lastUpdate: json["updated"],
    active: json["active"],
    flag: json["countryInfo"]["flag"],
    continent: json["continent"],
  );

}