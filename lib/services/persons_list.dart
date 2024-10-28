import 'dart:convert';
import 'package:http/http.dart' as http;

class PersonsListWebService{

  

  Future<dynamic> fetchPersonsListAPI({int page = 1, int limit = 15}) async {

    
    //cambiar la ip por la ip local donde se esté ejecutando la API
    var url = Uri.http('192.168.1.232:3000', '/personas', {'page': page.toString(), 'limit': limit.toString()});

    try{
      
      final response = await http.get(url);
      if(response.statusCode == 200) {
        print(response);
        return jsonDecode(response.body);

      } else {
        print("StatusCode not 200");
        return jsonDecode(response.body);
      }
    }
    catch(e){
      print("PersonsListWebService exception: $e");
    }
  }

  Future<dynamic> deletePersonAPI(int? id) async {

    

    //cambiar la ip por la ip local donde se esté ejecutando la API
    var url = Uri.http('192.168.1.232:3000', '/personas/$id');

    try{
      
      final response = await http.delete(url);
      if(response.statusCode == 200) {

        return jsonDecode(response.body);

      } else {
        print("StatusCode not 200");
        return jsonDecode(response.body);
      }
    }
    catch(e){
      print("PersonsListWebService exception: $e");
    }
  }
}