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
import 'package:icon_testing/services/search_person.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class SearchPersonViewModel extends ChangeNotifier {
    
  final TextEditingController searchController = TextEditingController();
  List<Person> searchPersonsList = [];
  bool isLoading=false;

  Future<void> searchPerson(String query)async{
    
    

      try{
        isLoading = true;
        final response  = await SearchPersonsListWebService().searchPersonsListAPI(query);
        searchPersonsList = response.map<Person>((json) => Person.fromJson(json)).toList();
        isLoading=false;
        notifyListeners();

      }catch(e){

        print("SearchPersonViewModel Exception: $e");
        
      }
    
    

  }
  
}