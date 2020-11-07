import 'package:covid_19/constants.dart';
import 'package:covid_19/screens/details_screen.dart';
import 'package:covid_19/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:covid_19/widgets/coronadata.dart';
import 'otherstates.dart';
import 'package:covid_19/screens/Precautions.dart';



class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
  }

  class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather=WeatherModel();
  int confirmedcases;
  int  deaths;
  int recovered;
  int active;
  @override
  void initState() {
  // TODO: implement initState
  super.initState();
  updateui(widget.locationweather,-1);
  }

  void updateui(dynamic weatherdata,var typedname) {
    setState(() {
      if (typedname == -1) {
        if (weatherdata == null) {
          confirmedcases = 0;
          deaths = 0;
          recovered = 0;
          active = 0;
          return;
        }
        confirmedcases = weatherdata['data']['unofficial-summary'][0]['total'];
        deaths = weatherdata['data']['unofficial-summary'][0]['deaths'];
        recovered = weatherdata['data']['unofficial-summary'][0]['recovered'];
        active = weatherdata['data']['unofficial-summary'][0]['active'];

      }
      else {
        confirmedcases = weatherdata['data']['regional'][typedname]['totalConfirmed'];
        deaths = weatherdata['data']['regional'][typedname]['deaths'];
        recovered = weatherdata['data']['regional'][typedname]['discharged'];
        active = confirmedcases - recovered;


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: kPrimaryColor.withOpacity(.03),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          onPressed: () {},
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              var typedname=await Navigator.push(context, MaterialPageRoute(builder: (context){
                return DropDown();
              },
              ),
              );

              if(typedname!=null)
              {

                var weatherdata=await weather.getcityweather();
                updateui(weatherdata,typedname);
              }
            },
            child: Icon(
              Icons.search,
              size: 30.0,
            ),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 40),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.03),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Wrap(
                  runSpacing: 20,
                  spacing: 20,
                  children: <Widget>[
                    InfoCard(
                      title: "Confirmed Cases",
                      iconColor: Color(0xFFFF8C00),
                      effectedNum: confirmedcases,
                      press: () {},
                    ),
                    InfoCard(
                      title: "Total Deaths",
                      iconColor: Color(0xFFFF2D55),
                      effectedNum: deaths,
                      press: () {},
                    ),
                    InfoCard(
                      title: "Total Recovered",
                      iconColor: Color(0xFF50E3C2),
                      effectedNum: recovered,
                      press: () {},
                    ),
                    InfoCard(
                      title: "Active Cases",
                      iconColor: Color(0xFF5856D6),
                      effectedNum: active,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DetailsScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Preventions",
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
//                     SizedBox(
//                       width: 120,
//                     ),
                    Align(

                      child:  FlatButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return InfoScreen();
                          },
                          ),
                          );
                        },
                        child: Icon(
                          Icons.search,
                          size: 30.0,
                        ),
                      ),
                    ),
                      ],
                    ),
                    SizedBox(height: 20),
                    buildPreventation(),
                    SizedBox(height: 20),
                    buildHelpCard(context),
                    SizedBox(height: 20),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  }
Row buildPreventation() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      PreventitonCard(
        svgSrc: "assets/icons/hand_wash.svg",
        title: "Wash Hands",
      ),
      PreventitonCard(
        svgSrc: "assets/icons/use_mask.svg",
        title: "Use Masks",
      ),
      PreventitonCard(
        svgSrc: "assets/icons/Clean_Disinfect.svg",
        title: "Clean Disinfect",
      ),
    ],
  );
}
  Container buildHelpCard(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              // left side padding is 40% of total width
              left: MediaQuery.of(context).size.width * .4,
              top: 20,
              right: 20,
            ),
            height: 130,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF60BE93),
                  Color(0xFF1B8D59),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Dial 1075 for \nNational Helpline!\n",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: Colors.white),
                  ),
                  TextSpan(
                    text: "If any symptoms appear",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SvgPicture.asset("assets/icons/nurse.svg"),
          ),
          Positioned(
            top: 30,
            right: 10,
            child: SvgPicture.asset("assets/icons/virus.svg"),
          ),
        ],
      ),
    );
  }



class PreventitonCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  const PreventitonCard({
    Key key,
    this.svgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(svgSrc),
        Text(
          title,
          style:
              Theme.of(context).textTheme.body2.copyWith(color: kPrimaryColor),
        )
      ],
    );
  }
}
