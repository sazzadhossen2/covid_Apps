import 'dart:convert';

import 'package:covid_19/service/utilities/app_utils.dart';
import 'package:http/http.dart' as http;

import '../../model/world_state_model.dart';
class StatesService{
  Future<WorldStateModel> fectworldstate()async{
    final responce =await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(responce.statusCode==200){
      var data =jsonDecode(responce.body);
      return WorldStateModel.fromJson(data);
    }
    else{
      throw Exception("Error");
    }

  }



  Future<List<dynamic>> countriesApi()async{
    var data;
    final responce =await http.get(Uri.parse(AppUrl.countriesList));
    if(responce.statusCode==200){
      data =jsonDecode(responce.body);
      return data;
    }
    else{
      throw Exception("Error");
    }

  }

}