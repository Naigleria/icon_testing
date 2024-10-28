import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:icon_testing/UI/UIHelper.dart';
import 'package:icon_testing/models/person.dart';
import 'package:icon_testing/viewmodels/edit_person.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class EditPersonScreen extends StatefulWidget {
  static String routeName = '/edit_person';
  const EditPersonScreen({Key? key}) : super(key: key);

  @override
  EditPersonScreenState createState() => EditPersonScreenState();
}


class EditPersonScreenState extends State<EditPersonScreen> {
  

  @override
  initState() {
    Provider.of<EditPersonViewModel>(context, listen: false).nombreController.clear();
    Provider.of<EditPersonViewModel>(context, listen: false).emailController.clear();
    Provider.of<EditPersonViewModel>(context, listen: false).edadController.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    EditPersonViewModel editPersonVM = Provider.of<EditPersonViewModel>(context);
    final person = ModalRoute.of(context)?.settings.arguments as Person;

    editPersonVM.nombreController.text=person.nombre;
    editPersonVM.emailController.text=person.email;
    editPersonVM.edadController.text=person.edad.toString();

    print("Widget Build");

    return PopScope(
      
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, "/persons_list");
              }, 
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30.0,
                color: Colors.white,
              )
            ),
            backgroundColor: Colors.lightBlue,
            title: Center(
              child: UIHelper.getText("Editar persona", 17.0, Colors.white, FontWeight.bold)
            ),
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: UIHelper.getText("Nombre"),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 20.0,),
                        Expanded(
                          child: TextField(
                            controller: editPersonVM.nombreController,
                            
                            decoration: InputDecoration(
                              //focusedborder cuando se esta focuseando el textfiel y enabledborder cuando no
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:  BorderSide(color: UIHelper.primaryBorderTextFieldGray, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:  BorderSide(color: UIHelper.primaryBorderTextFieldGray, width: 2.0),
                              ),
                              hintText: "No dejar campo vacío",
                              hintStyle: TextStyle(color: UIHelper.primaryBorderTextFieldGray),
                
                              //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                              prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                
                
                            ),
                
                            textInputAction: TextInputAction.next,
                
                          ),
                        ),
                        const SizedBox(width: 20.0,),
                      ],
                    ),
                    const SizedBox(height: 20.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: UIHelper.getText("Email"),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 20.0,),
                        Expanded(
                          child: TextField(
                            controller: editPersonVM.emailController,
                            
                            decoration: InputDecoration(
                              //focusedborder cuando se esta focuseando el textfiel y enabledborder cuando no
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:  BorderSide(color: UIHelper.primaryBorderTextFieldGray, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:  BorderSide(color: UIHelper.primaryBorderTextFieldGray, width: 2.0),
                              ),
                              hintText: "Introduce un email con formato válido",
                              hintStyle: TextStyle(color: UIHelper.primaryBorderTextFieldGray),
                
                              //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                              prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                
                
                            ),
                
                            textInputAction: TextInputAction.next,
                
                          ),
                        ),
                        const SizedBox(width: 20.0,),
                      ],
                    ),
                    const SizedBox(height: 20.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: UIHelper.getText("Edad"),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 20.0,),
                        Expanded(
                          child: TextField(
                            controller: editPersonVM.edadController,
                            
                            decoration: InputDecoration(
                              //focusedborder cuando se esta focuseando el textfiel y enabledborder cuando no
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:  BorderSide(color: UIHelper.primaryBorderTextFieldGray, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:  BorderSide(color: UIHelper.primaryBorderTextFieldGray, width: 2.0),
                              ),
                              hintText: "Introduce edad mayo a 0",
                              hintStyle: TextStyle(color: UIHelper.primaryBorderTextFieldGray),
                
                              //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                              prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                
                
                            ),
                
                            textInputAction: TextInputAction.next,
                
                          ),
                        ),
                        const SizedBox(width: 20.0,),
                      ],
                    ),
                    SizedBox(height: 40.0,),
                    Center(
                      child: UIHelper.getElevatedButton(null, 12.0, "Editar persona", 230.0, 40.0, 0.0, BorderSide.none, UIHelper.primaryButtonGreen, 
                        ()async {
                          if (editPersonVM.nombreController.text=="" || EmailValidator.validate(editPersonVM.emailController.text)==false || int.tryParse(editPersonVM.edadController.text)!<=0){
                            final warningsnackbar = UIHelper.getSnackBar("Cuidado!", "Campos no cumplen requisitos! ", ContentType.warning);
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(warningsnackbar);
                          }else{
                            var body ={
                              "name": editPersonVM.nombreController.text,
                              "email": editPersonVM.emailController.text,
                              "age": int.tryParse(editPersonVM.edadController.text)
                            };

                            
                            await editPersonVM.editPerson(body, person.id, context);
                            

                            if(!mounted)return;
                              Navigator.pushReplacementNamed(context, '/persons_list');
                            }
                          
                        }, 
                        17.0, 
                        Colors.white, 
                        FontWeight.bold
                      ),
                    ),

                    // Add more widgets as needed
                  ],
                ),
              ),
            ],
          )

        ),
        
      ),
    );



  }
}