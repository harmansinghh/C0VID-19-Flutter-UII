import 'package:flutter/material.dart';
import 'package:covid_19/screens/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid_19/widgets/coronadata.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getlocationdata();
  }
  void getlocationdata() async {
    WeatherModel weathermodel=WeatherModel();
    var weatherdata=await weathermodel.getcityweather();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationweather:weatherdata);
    },),);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child:SpinKitDoubleBounce(
          color:Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

