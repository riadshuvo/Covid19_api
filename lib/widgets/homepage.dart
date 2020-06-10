import 'package:connectivity/connectivity.dart';
import 'package:corona_covid19_api/bloc/covidCoronaBloc.dart';
import 'package:corona_covid19_api/constant.dart';
import 'package:corona_covid19_api/screens/my_header.dart';
import 'package:corona_covid19_api/widgets/showCoronaData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;
  var countryController = TextEditingController();
  var coronaDataBloc;

  bool internertconnection = false;

  @override
  void initState() {
    coronaDataBloc = BlocProvider.of<CovidCoronaBloc>(context);
    CheckStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CovidCoronaBloc, CovidCoronaState>(
        builder: (context, state) {
      if (state is CoronaDataIsNotSearched) {
        return ListView(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "All you need",
              textBottom: "is stay at home.",
              offset: offset,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 32,
                right: 32,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: countryController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.cyan,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors.brown, style: BorderStyle.solid)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                              color: Colors.blue, style: BorderStyle.solid)),
                      hintText: "Country Name/ISO Code",
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      onPressed: () {
                        if (countryController.text.isNotEmpty)
                          fetchCoronaData(countryController.text);
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Colors.lightBlue,
                      child: Text(
                        "Search",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Corona COVID-19  Information\n",
                          style: kTitleTextstyle,
                        ),
                        TextSpan(
                          text: "Search for show Update ",
                          style: TextStyle(
                            color: kTextLightColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      } else if (state is CoronaDataIsLoading) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is CoronaDataIsLoaded) {
        return ShowData(state.currentCoronaData);
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Please Search with Proper Country Name or Just Use Country ISO Code.\nExample: Bangladesh -> BD",
                style: TextStyle(color: kPrimaryColor, fontSize: 18.0),
              ),
              SizedBox(height: 30.0),
              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  onPressed: () {
                    coronaDataBloc.add(ResetCoronaData());
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: kPrimaryColor,
                  child: Text(
                    "Go Back",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void CheckStatus() {
    Connectivity().onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        setState(() {
          internertconnection = true;
        });
      } else {
        setState(() {
          internertconnection = false;
        });
      }
    });
  }

  void fetchCoronaData(String countryName) {
    if (internertconnection) {
      coronaDataBloc.add(FetchCoronaData(countryName));
    } else {
      final snackBar = SnackBar(
        content: Text('Check Your Internet Connection !!'),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
