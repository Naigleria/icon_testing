import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:icon_testing/UI/UIHelper.dart';
import 'package:icon_testing/models/person.dart';
import 'package:icon_testing/services/add_person.dart';
import 'package:icon_testing/services/persons_list.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class AddPersonViewModel extends ChangeNotifier {
    
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController edadController = TextEditingController();


  Future<void> addPerson(Map body, BuildContext context)async{
    ProgressDialog pd = ProgressDialog(context: context);

    // Define los SnackBars antes de las llamadas async para evitar problemas con el contexto
    final successSnackBar = UIHelper.getSnackBar("Muy bien!", "Persona creada exitosamente!", ContentType.success);
    final errorSnackBar = UIHelper.getSnackBar("Error!", "Error al intentar crear persona!", ContentType.failure);
    

      try{

        pd.show(msg: "Creando persona..");

        final response  = await AddPersonWebService().addPersonAPI(body);
        
        if (context.mounted) {
          pd.close();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(successSnackBar);
        }

        

        notifyListeners();
      }catch(e){

        if (context.mounted) {
          pd.close();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(errorSnackBar);
        }
        
        print("AddPersonViewModel Exception: $e");
        
      }
    
    

  }
  
}