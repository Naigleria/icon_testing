import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icon_testing/UI/UIHelper.dart';
import 'package:icon_testing/models/person.dart';
import 'package:icon_testing/viewmodels/persons_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class PersonsListScreen extends StatefulWidget {
  static String routeName = '/persons_list';
  const PersonsListScreen({Key? key}) : super(key: key);

  @override
  PersonsListScreenState createState() => PersonsListScreenState();
}


class PersonsListScreenState extends State<PersonsListScreen> {
  String nombre="Persona1";
  String email="email1@email1.com";
  int edad=20;

  

  @override
  initState() {
    
    Provider.of<PersonsListViewModel>(context, listen: false).fetchPersonsList();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    PersonsListViewModel personsListVM = Provider.of<PersonsListViewModel>(context);
    //final generalAppInfo = Provider.of<GeneralAppInfo>(context);

    print("Widget Build");
    //loginVM.usernameController.clear();
    //loginVM.passwordController.clear();
    Future<void> showDialogDeletePerson(int index,  BuildContext context, Person person) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: UIHelper.primaryBlueCard,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            content: SingleChildScrollView(
              child: Column(
                children:   <Widget>[
                  UIHelper.getText("¿Seguro que quiere eliminar", 15.0, UIHelper.darkBlueTextCard),
                  UIHelper.getText("ésta persona?", 15.0, UIHelper.darkBlueTextCard),
                  const SizedBox(height: 10.0,),
                  
                  const SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UIHelper.getElevatedButton(
                        null,
                        12.0,
                        "No",
                        100.0,
                        35.0,
                        0.0,
                        BorderSide(color: UIHelper.primaryOrange, width: 1),
                        Colors.white,
                        (){
                          
                          Navigator.of(context).pop();
                        },
                        15.0,
                        UIHelper.primaryOrange,

                      ),
                      UIHelper.getElevatedButton(
                        null,
                        12.0,
                        "Sí",
                        100.0,
                        35.0,
                        0.0,
                        BorderSide.none,
                        UIHelper.primaryBlueBold,
                        () async {
                          
                          

                          
                          await personsListVM.deletePerson(person.id, context);
                          
                          await personsListVM.fetchPersonsList();
                          Navigator.of(context).pop();
                        },
                        15.0,
                        Colors.white

                      )

                    ],
                  )
                ],
              ),
            ),

          );
        },
      );
    }

    return PopScope(
      
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppBar(
            backgroundColor: Colors.lightBlue,
            title: Center(
              child: UIHelper.getText("Lista de personas", 17.0, Colors.white, FontWeight.bold)
            ),
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/search_person");
                },
                icon: const Icon(
                  Icons.search,
                  size: 30.0,
                  color: Colors.white,
                )
              )
            ],
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  
                  children: [
                    
                    
                    personsListVM.isLoading?
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ): 
                    personsListVM.isLoading==false && personsListVM.persons.isNotEmpty?
                    Expanded(
                      child: ListView.builder(
                        itemCount: personsListVM.persons.length, 
                        itemBuilder: (BuildContext context, int index) {
                          
                          return Slidable(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: UIHelper.getText("Nombre: ${personsListVM.persons[index].nombre}"),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: UIHelper.getText("Email: ${personsListVM.persons[index].email}"),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: UIHelper.getText("Edad: ${personsListVM.persons[index].edad}"),
                                ),
                                
                                const SizedBox(height: 20.0,)
                              ],
                            ),
                            key: const ValueKey(0),

                            
                            startActionPane: ActionPane(
                              extentRatio: 0.9,
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (BuildContext context){
                                    showDialogDeletePerson(index, context, personsListVM.persons[index]);
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Eliminar',
                                  
                                  autoClose: true,
                                ),
                                SlidableAction(
                                  onPressed: (BuildContext context){
                                    Navigator.pushReplacementNamed(context, "/edit_person", arguments: personsListVM.persons[index]);
                                  },
                                  backgroundColor: Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Editar',
                                  
                                  autoClose: true,
                                ),
                              ],
                            ),
                            
                          );
                          
                        },
                      ),
                    ):
                    Expanded(
                      child: Center(
                        child: UIHelper.getText("No hay personas dadas de alta"),
                      ),
                    ),
                    Container(
                      height: 90.0,
                      decoration: BoxDecoration(
                        border: Border.all()
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: InkWell(
                                child: Container(
                                  height: 45.0,
                                  width: 45.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    ),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset("assets/skip-back.svg"),
                                  ),
                                ),
                                onTap: ()async{
                                  if(personsListVM.currentPage!=1){
                                    await personsListVM.fetchPersonsList(page: personsListVM.currentPage-1);
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: ScrollablePositionedList.builder(
                                itemScrollController: personsListVM.itemScrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: personsListVM.totalPages,
                                itemBuilder: (BuildContext context, int index){
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(10.0, 11.0, 10.0, 11.0),
                                    child: InkWell(
                                      child: Container(
                                        height: 15.0,
                                        width: 45.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)
                                          ),
                                          color: personsListVM.currentPage==(index+1)?
                                            Colors.lightBlue:
                                            null
                                        ),
                                        child: Center(
                                          child: UIHelper.getText(
                                            (index+1).toString(),
                                            17.0,
                                            personsListVM.currentPage==(index+1)?
                                              Colors.white:
                                              Colors.black,
                                            FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      onTap: ()async{
                                        if((index+1)!=personsListVM.currentPage){
                                          await personsListVM.fetchPersonsList(page: (index+1));
                                        }
                                        
                                      },
                                    ),
                                  );
                                }
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: InkWell(
                                child: Container(
                                  height: 45.0,
                                  width: 45.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    ),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset("assets/skip-forward.svg"),
                                  ),
                                ),
                                onTap: ()async{
                                  if(personsListVM.currentPage!=personsListVM.totalPages){
                                    await personsListVM.fetchPersonsList(page: personsListVM.currentPage+1);
                                  }
                                },
                              ),
                            ),
                          ],
                        )
                      ),
                    )
                    // Add more widgets as needed
                  ],
                ),
              ),
            ],
          )

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/add_person");
            print("object");
          },
          child: Icon(Icons.add),  // Icono del botón
        ),
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(0.0, -90.0),
      ),
    );



  }




}

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final double offsetX;
  final double offsetY;

  CustomFloatingActionButtonLocation(this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = scaffoldGeometry.scaffoldSize.width - scaffoldGeometry.floatingActionButtonSize.width - 16.0 + offsetX;
    final double fabY = scaffoldGeometry.scaffoldSize.height - scaffoldGeometry.floatingActionButtonSize.height - 16.0 + offsetY;

    return Offset(fabX, fabY);
  }
}