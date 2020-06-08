import 'package:corona_covid19_api/bloc/covidCoronaBloc.dart';
import 'package:corona_covid19_api/constant.dart';
import 'package:corona_covid19_api/screens/my_header.dart';
import 'package:corona_covid19_api/widgets/showCoronaData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class HomeScreen extends StatelessWidget {
  final controller = ScrollController();
  double offset = 0;

  @override
  Widget build(BuildContext context) {
    final coronaDataBloc = BlocProvider.of<CovidCoronaBloc>(context);
    var countryController = TextEditingController();

    void fetchCoronaData() async {
      DataConnectionStatus dataConnectionStatus = await checkInterConnection();

      if (dataConnectionStatus == DataConnectionStatus.connected) {
        coronaDataBloc.add(FetchCoronaData(countryController.text));
      } else {
        final snackBar = SnackBar(
          content: Text('Check Your Internet Connection !!'),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      }
      countryController.clear();
    }

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
                        fetchCoronaData();
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
      return Text(
        "Eroor",
        style: TextStyle(color: Colors.amber, fontSize: 20.0),
      );
    });
  }

  checkInterConnection() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    var listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
    await Future.delayed(Duration(milliseconds: 1));
    await listener.cancel();

    return await DataConnectionChecker().connectionStatus;
  }
}
