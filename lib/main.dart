import 'package:corona_covid19_api/bloc/covidCoronaBloc.dart';
import 'package:corona_covid19_api/bloc/covidCoronaModel.dart';
import 'package:corona_covid19_api/bloc/covidCoronaRepo.dart';
import 'package:corona_covid19_api/constant.dart';
import 'package:corona_covid19_api/widgets/counter.dart';
import 'package:corona_covid19_api/widgets/my_header.dart';
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

class HomeScreen extends StatelessWidget {
  final controller = ScrollController();
  double offset = 0;
  @override
  Widget build(BuildContext context) {
    final coronaDataBloc = BlocProvider.of<CovidCoronaBloc>(context);
    var cityController = TextEditingController();
    return BlocBuilder<CovidCoronaBloc,CovidCoronaState>(
        builder: (context, state){
          if(state is CoronaDataIsNotSearched){
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
                        controller: cityController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.cyan,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Colors.brown,
                                  style: BorderStyle.solid)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid)),
                          hintText: "Country Name",
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
                            coronaDataBloc.add(FetchCoronaData(cityController.text));
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
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
          }
          else if(state is CoronaDataIsLoading){
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else if(state is CoronaDataIsLoaded){
            return ShowData(state.currentCoronaData.first);
          }
          return Text("Eroor", style: TextStyle(color: Colors.amber, fontSize: 20.0),);
        });
  }
}

class ShowData extends StatelessWidget {
  CovidCoromaModelClass coronaData;
  ShowData(this.coronaData);
  @override
  Widget build(BuildContext context) {
    final coronaDataBloc = BlocProvider.of<CovidCoronaBloc>(context);
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Case Update\n",
                        style: kTitleTextstyle,
                      ),
                      TextSpan(
                        text: " ${coronaData.getDate}",
                        style: TextStyle(
                          color: kTextLightColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  "${coronaData.countryRegion}",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 30,
                    color: kShadowColor,
                  ),
                ],
              ),
              child: Wrap(
                runSpacing: 10.0,
                spacing: 20.0,
                alignment: WrapAlignment.spaceAround,
                runAlignment: WrapAlignment.center,
                direction: Axis.horizontal,
                children: <Widget>[
                  Counter(
                    color: kInfectedColor,
                    number: coronaData.confirmed,
                    title: "Infected",
                  ),
                  Counter(
                    color: kDeathColor,
                    number: coronaData.deaths,
                    title: "Deaths",
                  ),
                  Counter(
                    color: kRecovercolor,
                    number: coronaData.recovered,
                    title: "Recovered",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Spread of Virus",
                  style: kTitleTextstyle,
                ),
                Text(
                  "See details",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(20),
              height: 178,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 30,
                    color: kShadowColor,
                  ),
                ],
              ),
              child: Image.asset(
                "assets/images/map.png",
                fit: BoxFit.contain,
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                onPressed: () {
                  coronaDataBloc.add(ResetCoronaData());
                },
                shape: new RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10))),
                color: Colors.lightBlue,
                child: Text(
                  "Search Again",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
