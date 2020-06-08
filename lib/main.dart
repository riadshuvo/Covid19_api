import 'package:corona_covid19_api/bloc/covidCoronaBloc.dart';
import 'package:corona_covid19_api/bloc/covidCoronaRepo.dart';
import 'package:corona_covid19_api/constant.dart';
import 'package:corona_covid19_api/widgets/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid 19',
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            fontFamily: "Poppins",
            textTheme: TextTheme(
              body1: TextStyle(color: kBodyTextColor),
            )),
        home: Scaffold(
            body: BlocProvider(
              builder: (context) => CovidCoronaBloc(CovidCoronaRepoClass()),
              child: HomeScreen(),
            )));
  }
}


