import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icon_testing/UI/UIHelper.dart';
import 'package:icon_testing/viewmodels/add_person.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class AddPersonScreen extends StatefulWidget {
  static String routeName = '/add_person';
  const AddPersonScreen({Key? key}) : super(key: key);

  @override
  AddPersonScreenState createState() => AddPersonScreenState();
}


class AddPersonScreenState extends State<AddPersonScreen> {
  

  @override
  initState() {
    Provider.of<AddPersonViewModel>(context, listen: false).nombreController.clear();
    Provider.of<AddPersonViewModel>(context, listen: false).emailController.clear();
    Provider.of<AddPersonViewModel>(context, listen: false).edadController.clear();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    AddPersonViewModel addPersonVM = Provider.of<AddPersonViewModel>(context);
    //final generalAppInfo = Provider.of<GeneralAppInfo>(context);

    print("Widget Build");
    //loginVM.usernameController.clear();
    //loginVM.passwordController.clear();

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
              child: UIHelper.getText("Agregar persona", 17.0, Colors.white, FontWeight.bold)
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
                            controller: addPersonVM.nombreController,
                            
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
                            controller: addPersonVM.emailController,
                            
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
                            controller: addPersonVM.edadController,
                            
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
                              hintText: "Introduce edad mayor a 0",
                              hintStyle: TextStyle(color: UIHelper.primaryBorderTextFieldGray),
                
                              //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                              prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                
                
                            ),
                            keyboardType: TextInputType.number,  // Muestra el teclado numérico
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly  // Solo permite dígitos
                            ],
                            textInputAction: TextInputAction.next,
                
                          ),
                        ),
                        const SizedBox(width: 20.0,),
                      ],
                    ),
                    SizedBox(height: 40.0,),
                    Center(
                      child: UIHelper.getElevatedButton(null, 12.0, "Agregar persona", 230.0, 40.0, 0.0, BorderSide.none, UIHelper.primaryButtonGreen, 
                        ()async {
                          
                          if (addPersonVM.nombreController.text=="" || EmailValidator.validate(addPersonVM.emailController.text)==false || int.tryParse(addPersonVM.edadController.text)!<=0){
                            final warningsnackbar = UIHelper.getSnackBar("Cuidado!", "Campos no cumplen requisitos! ", ContentType.warning);
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(warningsnackbar);
                          }else{
                            var body ={
                              "name": addPersonVM.nombreController.text,
                              "email": addPersonVM.emailController.text,
                              "age": int.tryParse(addPersonVM.edadController.text)
                            };
                            await addPersonVM.addPerson(body, context);
                          

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