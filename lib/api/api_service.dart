// ignore_for_file: unused_import

import 'package:http/http.dart';

class APIService{
 Future<http.Response> requestOpenAI(String userInput,String mode,String apikey,int maximumTokens) async{
  final String OpenAIAPIurl = mode == "chat" ? "v1/completions" : "v1/images/generations";
 }
}