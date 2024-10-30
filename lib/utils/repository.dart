import 'dart:convert';

import 'package:http/http.dart' as http;

// const String _server_address = "http://harshanpvtserver.duckdns.org:8000";
const String _server_address = "http://192.168.1.8:8000";

Future<bool> getHeartBeat() async{
  try {
      var response = await http.get(Uri.parse("$_server_address/heartbeat"));
      if (response.statusCode == 200) {
        return true;
      }
      else{
        print("got a bad response from server");
      }
    } catch (e) {
      print(e);
    }

    return false;
}

Future<String> getTemp() async {
    try {
      var response = await http.get(Uri.parse("$_server_address/ssdtemp"));
      if (response.statusCode == 200) {
        var jsonresponse = jsonDecode(response.body);
        return jsonresponse['Temp'].toString(); 
      }
      else{
        print("got a bad response from server");
      }
    } catch (e) {
      print(e);
    }

    return "";
  }


Future<List<String>> getLogs() async{
  try {
      var response = await http.get(Uri.parse("$_server_address/log"));
      if (response.statusCode == 200) {
        var jsonresponse = jsonDecode(response.body);
        return List<String>.from(jsonresponse['Logs']); 
      }
      else{
        print("got a bad response from server");
      }
    } catch (e) {
      print(e);
    }

    return []; 
  }

Future<List<int>> getStorage() async{
  try {
      var response = await http.get(Uri.parse("$_server_address/storage"));
      if (response.statusCode == 200) {
        var jsonresponse = jsonDecode(response.body);
        int _per = int.parse(jsonresponse['Percent'].substring(0,2));
        int _tot = (int.parse(jsonresponse['Total'])/(1024*1024)).round();
        int _used = (_tot*_per/100).round();
        return [_per,_tot,_used];
      }
      else{
        print("got a bad response from server");
      }
    } catch (e) {
      print(e);
    }

    return []; 
  }
