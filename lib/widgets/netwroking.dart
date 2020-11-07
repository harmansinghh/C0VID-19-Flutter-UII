import 'package:http/http.dart' as http;
import 'dart:convert';

class Networkhelper{
  Networkhelper(this.url);
  final String url;
  Future getdata() async {
    http.Response response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeddata = jsonDecode(data);
      return decodeddata;
    }
    else {
      print(response.statusCode);
    }
  }

}