import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_testing/UI/UIHelper.dart';
import 'package:icon_testing/services/edit_person.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class EditPersonViewModel extends ChangeNotifier {

  
  bool isVendor=false;
  
  
    
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController edadController = TextEditingController();


  Future<void> editPerson(Map body, int? id, BuildContext context)async{
    ProgressDialog pd = ProgressDialog(context: context);

    // Define los SnackBars antes de las llamadas async para evitar problemas con el contexto
    final successSnackBar = UIHelper.getSnackBar("Muy bien!", "Persona editada exitosamente!", ContentType.success);
    final errorSnackBar = UIHelper.getSnackBar("Error!", "Error al intentar editar persona!", ContentType.failure);
    

    try{
      pd.show(msg: "Editando persona..");
      final response  = await EditPersonWebService().editPersonAPI(body, id);

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
      print("EditPersonViewModel Exception: $e");
    }
    
    

  }

  
}