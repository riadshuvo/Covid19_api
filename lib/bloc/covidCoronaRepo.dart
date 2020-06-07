
import 'package:corona_covid19_api/bloc/covidCoronaModel.dart';
import 'package:http/http.dart' as http;

class CovidCoronaRepoClass{

   Future<List<CovidCoromaModelClass>> getCoronaData(String country) async{
     String url='https://covid19.mathdro.id/api/countries/$country/confirmed';
     try{
       final responses = await http.get(url);
       if(responses.statusCode== 200){
         final List<CovidCoromaModelClass> result = coronaDataFromJson(responses.body);
         return result;
       }
       else{
         return List<CovidCoromaModelClass>();
       }
     }
     catch (e){
       return List<CovidCoromaModelClass>();
     }
  }
}