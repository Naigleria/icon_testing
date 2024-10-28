import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPersonsListWebService{

  Future<dynamic> searchPersonsListAPI(String query) async {

    //cambiar la ip por la ip local donde se esté ejecutando la API
    var url = Uri.http('192.168.1.232:3000', '/personas/search', {'query': query});

    try{
      
      final response = await http.get(url);
      if(response.statusCode == 200) {

        return jsonDecode(response.body);

      } else {
        print("StatusCode not 200");
        return jsonDecode(response.body);
      }
    }
    catch(e){
      print("SearchPersonsListWebService exception: $e");
    }
  }

  
}