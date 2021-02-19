import 'dart:convert';
import 'package:http/http.dart';


class Services{

  static const String url ='https://www.themealdb.com/api/json/v1/1/random.php';

  static Future <Map> getRecord() async {

    try{
      final response = await get(url);
      final Map records = jsonDecode(response.body);
      return records;
    }catch(e){
      print('error');
      print(e);
    }
    return null;
  }
}