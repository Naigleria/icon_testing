import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:icon_testing/UI/UIHelper.dart';
import 'package:icon_testing/models/person.dart';
import 'package:icon_testing/services/persons_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class PersonsListViewModel extends ChangeNotifier {
  
  int totalPages=0;
  int currentPage=0;
  bool isLoading=true;
  
  List<Person> persons = [];
    
  final TextEditingController numberCardController = TextEditingController();
  final TextEditingController expirationDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();
  
  final ItemScrollController itemScrollController = ItemScrollController();

  

  Future<void> fetchPersonsList({int page = 1, int limit = 15})async{
    try{
      isLoading=true;
      

      final response  = await PersonsListWebService().fetchPersonsListAPI(page: page, limit: limit);
      persons = response["data"].map<Person>((json) => Person.fromJson(json)).toList();
      totalPages=response["totalPages"];
      currentPage=response["currentPage"];
      
      print(response);
      isLoading=false;
      notifyListeners();
      
    }catch(e){
      print("personsListViewModel Exception: $e");
    }

  }

  Future<void> deletePerson(int? id, BuildContext mainContext) async {
    ProgressDialog pd = ProgressDialog(context: mainContext);

    // Define los SnackBars antes de las llamadas async para evitar problemas con el contexto
    final successSnackBar = UIHelper.getSnackBar("Muy bien!", "Persona eliminada exitosamente!", ContentType.success);
    final errorSnackBar = UIHelper.getSnackBar("Error!", "Error al intentar eliminar persona!", ContentType.failure);

    try {
      pd.show(msg: "Eliminando persona..");

      // Llama a la API para eliminar la persona
      final response = await PersonsListWebService().deletePersonAPI(id);

      
      

      // Usa un mounted check para asegurarte de que el contexto aún es válido
      if (mainContext.mounted) {
        pd.close();
        ScaffoldMessenger.of(mainContext)
          ..hideCurrentSnackBar()
          ..showSnackBar(successSnackBar);
      }
    } catch (e) {

      if (mainContext.mounted) {
        pd.close(); 
        ScaffoldMessenger.of(mainContext)
          ..hideCurrentSnackBar()
          ..showSnackBar(errorSnackBar);
      }
      print("personsListViewModel Exception: $e");
    }
  }

  
}