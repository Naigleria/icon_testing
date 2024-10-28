import 'dart:convert';
import 'package:http/http.dart' as http;

class EditPersonWebService{

  Future<dynamic> editPersonAPI(Map body, int? id) async {

    
    //cambiar la ip por la ip local donde se esté ejecutando la API
    var url = Uri.http('192.168.1.232:3000', '/personas/$id');
    
    try{
      print(jsonEncode(body));
      final response = await http.put(url,
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
      print("EditPersonWebService exception: $e");
    }
  }
}