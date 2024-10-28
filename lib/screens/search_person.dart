import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icon_testing/UI/UIHelper.dart';
import 'package:icon_testing/viewmodels/add_person.dart';
import 'package:icon_testing/viewmodels/search_person.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class SearchPersonScreen extends StatefulWidget {
  static String routeName = '/search_person';
  const SearchPersonScreen({Key? key}) : super(key: key);

  @override
  SearchPersonScreenState createState() => SearchPersonScreenState();
}


class SearchPersonScreenState extends State<SearchPersonScreen> {
  

  @override
  initState() {
    Provider.of<SearchPersonViewModel>(context, listen: false).searchController.clear();
    
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SearchPersonViewModel searchPersonVM = Provider.of<SearchPersonViewModel>(context);
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
              child: UIHelper.getText("Buscar persona", 17.0, Colors.white, FontWeight.bold)
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
                      child: UIHelper.getText("Introduce nombre o email"),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 20.0,),
                        Expanded(
                          child: TextField(
                            controller: searchPersonVM.searchController,
                            
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
                              hintText: "buscar por nombre o email",
                              hintStyle: TextStyle(color: UIHelper.primaryBorderTextFieldGray),
                
                              //prefixIcon: Container(color: Colors.red, height: 20.5, width: 20.5,),
                              prefixIconConstraints: const BoxConstraints(minHeight: 2.0, minWidth: 2.0),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                
                
                            ),
                
                            textInputAction: TextInputAction.done,
                            onSubmitted: (String query)async{
                              await searchPersonVM.searchPerson(query);
                              print(query);
                            },
                            
                          ),
                        ),
                        const SizedBox(width: 20.0,),
                      ],
                    ),
                    const SizedBox(height: 20.0,),
                    Expanded(
                      child: searchPersonVM.isLoading?
                      const Center(
                        child: CircularProgressIndicator(),
                      ):
                      ListView.builder(
                        itemCount: searchPersonVM.searchPersonsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: UIHelper.getText("Nombre: ${searchPersonVM.searchPersonsList[index].nombre}"),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: UIHelper.getText("Email: ${searchPersonVM.searchPersonsList[index].email}"),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: UIHelper.getText("Edad: ${searchPersonVM.searchPersonsList[index].edad}"),
                                ),
                                
                                const SizedBox(height: 20.0,)
                              ],
                            );
                        }
                      )
                    )
                    
                    
                    

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