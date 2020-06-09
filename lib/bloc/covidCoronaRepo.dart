
import 'package:corona_covid19_api/bloc/covidCoronaModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CovidCoronaRepoClass{

   Future<CovidCoromaModelClass> getCoronaData(String country) async{
     //String url='https://covid19.mathdro.id/api/countries/$country/confirmed';
      String url = "https://corona.lmao.ninja/v2/countries/$country";

       final responses = await http.get(url);

       if(responses.statusCode != 200){
         throw Exception();

       }
         return parsedJson(responses.body);

  }

   CovidCoromaModelClass parsedJson(final response) {
     final jsonDecoded = json.decode(response);
     return CovidCoromaModelClass.fromJson(jsonDecoded);
   }
}