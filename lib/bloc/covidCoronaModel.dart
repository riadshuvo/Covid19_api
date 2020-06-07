
import 'dart:convert';
import 'package:intl/intl.dart';

List<CovidCoromaModelClass> coronaDataFromJson(String str) => List<CovidCoromaModelClass>.from(json.decode(str).map((x) => CovidCoromaModelClass.fromJson(x)));

String coronaDataToJson(List<CovidCoromaModelClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class CovidCoromaModelClass{
  final lastUpdate;
  final confirmed;
  final recovered;
  final deaths;
  final countryRegion;

  static var formate = new DateFormat.yMMMMd("en_US").add_jm();

  String get getDate => formate.format(
      new DateTime.fromMicrosecondsSinceEpoch(
          lastUpdate * 1000));

  CovidCoromaModelClass({this.lastUpdate, this.confirmed, this.recovered, this.deaths, this.countryRegion});

  factory CovidCoromaModelClass.fromJson(Map<String, dynamic> json) => CovidCoromaModelClass(
    lastUpdate: json["lastUpdate"],
    confirmed: json["confirmed"],
    recovered: json["recovered"],
    deaths: json["deaths"],
    countryRegion: json["countryRegion"],
  );

  Map<String, dynamic> toJson() => {
    "lastUpdate": lastUpdate,
    "confirmed": confirmed,
    "recovered": recovered,
    "deaths": deaths,
    "countryRegion": countryRegion,
  };
}