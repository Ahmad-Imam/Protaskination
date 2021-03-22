import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkHelper
{
  NetworkHelper(this.url);
  final String url;

  Future getData() async
  {
    Response response = await get(url);
    //print(response.body);
    if(response.statusCode==200) {
      var decoderData = jsonDecode(response.body);
      return decoderData;
    }
    else
      print(response.statusCode);
  }



}