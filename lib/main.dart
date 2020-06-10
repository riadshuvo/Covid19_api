import 'package:corona_covid19_api/bloc/covidCoronaBloc.dart';
import 'package:corona_covid19_api/bloc/covidCoronaRepo.dart';
import 'package:corona_covid19_api/constant.dart';
import 'package:corona_covid19_api/widgets/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

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
            body:DoubleBackToCloseApp(
              snackBar: const SnackBar(content: Text("Tap back again to exit")),
              child:  BlocProvider(
                builder: (context) => CovidCoronaBloc(CovidCoronaRepoClass()),
                child: HomeScreen(),
              ),
            )));
  }
}


