import 'dart:convert';
import 'package:http/http.dart' as http;

class AddPersonWebService{

  

  Future<dynamic> addPersonAPI(Map body) async {

    
    //cambiar la ip por la ip local donde se esté ejecutando la API
    var url = Uri.http('192.168.1.232:3000', '/personas');
    
    try{
      print(jsonEncode(body));
      final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json', // Establece el tipo de contenido
        },

        body: jsonEncode(body)
      );
      if(response.statusCode == 201) {

        return jsonDecode(response.body);

      } else {
        print(response.body);
        print("StatusCode not 201");
        return jsonDecode(response.body);
      }
    }
    catch(e){
      print("AddPersonWebService exception: $e");
    }


  }
}