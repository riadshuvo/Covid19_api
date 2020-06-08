import 'package:corona_covid19_api/bloc/covidCoronaBloc.dart';
import 'package:corona_covid19_api/bloc/covidCoronaModel.dart';
import 'package:corona_covid19_api/constant.dart';
import 'package:corona_covid19_api/screens/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';

class ShowData extends StatelessWidget {
  CovidCoromaModelClass coronaData;

  ShowData(this.coronaData);

  @override
  Widget build(BuildContext context) {
    final coronaDataBloc = BlocProvider.of<CovidCoronaBloc>(context);
    return SafeArea(
      child: SingleChildScrollView(
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
                    "${coronaData.country}",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 20.0,
                    width: 20.0,
                    child: Image.network(
                      coronaData.flag,
                      fit: BoxFit.fill,
                    ),
                  )
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 20.0,
                      spacing: 20.0,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: coronaData.todayCases,
                          title: "New Infected",
                        ),
                        Counter(
                          color: kDeathColor,
                          number: coronaData.todayDeaths,
                          title: "New Deaths",
                        ),
                        Counter(
                          color: kRecovercolor,
                          number: coronaData.todayRecovered,
                          title: "New Recovered",
                        ),
                      ],
                    ),
                    new Container(
                        width: double.infinity,
                        child: new Divider(
                          thickness: 1.0,
                          color: Colors.grey[300],
                        )),
                    SizedBox(height: 20),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 20.0,
                      spacing: 20.0,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kInfectedColor,
                          number: coronaData.totalConfirmed,
                          title: "Total Infected",
                        ),
                        Counter(
                          color: kDeathColor,
                          number: coronaData.deaths,
                          title: "Total Deaths",
                        ),
                        Counter(
                          color: kRecovercolor,
                          number: coronaData.recovered,
                          title: "Total Recovered",
                        ),
                      ],
                    ),
                    new Container(
                        width: double.infinity,
                        child: new Divider(
                          thickness: 1.0,
                          color: Colors.grey[300],
                        )),
                    SizedBox(height: 20),
                    Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: 20.0,
                      spacing: 20.0,
                      alignment: WrapAlignment.center,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: <Widget>[
                        Counter(
                          color: kPrimaryColor,
                          number: coronaData.totalTasted,
                          title: "Total Tests",
                        ),
                        Counter(
                          color: kDeathColor,
                          number: coronaData.critical,
                          title: "Critical",
                        ),
                        Counter(
                          color: kInfectedColor,
                          number: coronaData.active,
                          title: "Active Patience",
                        ),
                      ],
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
      ),
    );
  }
}
