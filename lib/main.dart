
//flutter
import 'package:flutter/material.dart';



import 'package:provider/provider.dart';

//screens
import 'package:icon_testing/screens/persons_list.dart';
import 'package:icon_testing/screens/add_person.dart';
import 'package:icon_testing/screens/edit_person.dart';
import 'package:icon_testing/screens/search_person.dart';

//viewmodels
import 'package:icon_testing/viewmodels/persons_list.dart';
import 'package:icon_testing/viewmodels/add_person.dart';
import 'package:icon_testing/viewmodels/edit_person.dart';
import 'package:icon_testing/viewmodels/search_person.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  //await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  

  

  @override
  void initState() {
    super.initState();

    
    //request permission to user to get push notifications
    
    
    
    
    //Get FCM token for this device
    
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        //hay que registrar todos los viewmodels por que sino truena cuando se quieran
        //instanciar en el Widget Build de las screens
        //ChangeNotifierProvider(create: (context) =>GeneralAppInfo()),
        
        ChangeNotifierProvider(create:(context)=>PersonsListViewModel()),
        ChangeNotifierProvider(create:(context)=>AddPersonViewModel()),
        ChangeNotifierProvider(create:(context)=>EditPersonViewModel()),
        ChangeNotifierProvider(create: (context)=>SearchPersonViewModel())
        //ChangeNotifierProvider(create:(context)=>EditTaskViewModel()),
        //ChangeNotifierProvider(create:(context)=>HistoryViewModel()),
        //ChangeNotifierProvider(create:(context)=>HistoryCompletedTaskViewModel()),

      ],
      child: MaterialApp(
        title: "Anuncia Match",
        debugShowCheckedModeBanner: false,
       /* home:
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
          child: const LoginScreen(),

        ),*/
        initialRoute: '/persons_list',
        routes:
        {

          PersonsListScreen.routeName:(context) => const PersonsListScreen(),
          AddPersonScreen.routeName:(context) => const AddPersonScreen(),
          EditPersonScreen.routeName:(context) => const EditPersonScreen(),
          SearchPersonScreen.routeName:(context)=>const SearchPersonScreen(),
          //NewTaskScreen.routeName:(context) => const NewTaskScreen(),
          //EditTaskScreen.routeName:(context) => const EditTaskScreen(),
          //HistoryScreen.routeName:(context) => const HistoryScreen(),
          //HistoryCompletedTaskScreen.routeName:(context) => const HistoryCompletedTaskScreen(),
          //NominaDescriptionScreen.routeName:(context) => NominaDescriptionScreen(),
          //NominaListScreen.routeName:(context) => NominaListScreen()
        },
      ),
    );
  }

}