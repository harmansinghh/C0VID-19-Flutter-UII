import 'netwroking.dart';
import 'package:covid_19/widgets/loading.dart';


class WeatherModel {
  Future<dynamic> getcityweather() async {
    var url = 'https://api.rootnet.in/covid19-in/stats/latest';
    Networkhelper helper = Networkhelper(url);
    var weatherdata = await helper.getdata();
    return weatherdata;
  }

  Future<dynamic> getlocationweather(String str) async {
    var url = 'https://api.rootnet.in/covid19-in/stats/latest';
    Location location = Location();
    await location.getlocation();
    Networkhelper helper = Networkhelper(url);
    var weatherdata = await helper.getdata();
    return weatherdata;
  }

}
