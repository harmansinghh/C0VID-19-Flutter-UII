import 'package:flutter/material.dart';
import 'package:covid_19/constants.dart';

class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "DropDown Demo";

  @override
  DropDownState createState() => DropDownState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(0, 'Andaman and Nicobar Islands'),
      Company(1, 'Andhra Pradesh'),
      Company(2, 'Arunachal Pradesh'),
      Company(3, 'Assam'),
      Company(4, 'Bihar'),
      Company(5, 'Chandigarh'),
      Company(6, 'Chhattisgarh'),
      Company(7, 'Dadar Nagar Haveli'),
      Company(8, 'Delhi'),
      Company(9, 'Goa'),
      Company(10, 'Gujarat'),
      Company(11, 'Haryana'),
      Company(12, 'Himachal Pradesh'),
      Company(13, 'Jammu and Kashmir'),
      Company(14, 'Jharkhand'),
      Company(15, 'Karnataka'),
      Company(16, 'Kerala'),
      Company(17, 'Ladakh'),
      Company(18, 'Madhya Pradesh'),
      Company(19, 'Maharashtra'),
      Company(20, 'Manipur'),
      Company(21, 'Nagaland'),
      Company(22, 'Odisha'),
      Company(23, 'Puducherry'),
      Company(24, 'Punjab'),
      Company(25, 'Rajasthan'),
      Company(26, 'Sikkim'),
      Company(27, 'Tamil Nadu'),
      Company(28, 'Telengana'),
      Company(29, 'Tripura'),
      Company(30, 'Uttarakhand'),
      Company(31, 'Uttar Pradesh'),
      Company(32, 'West Bengal'),




    ];
  }
}

class DropDownState extends State<DropDown> {
  //
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("Statewise Data"),

      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
            height: 300.0,
            width: 300.0,
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://cdn5.vectorstock.com/i/1000x1000/15/94/coronavirus-mosaic-india-map-with-distress-vector-29151594.jpg'),
                fit: BoxFit.fill,
              ),
             // borderRadius:
              //BorderRadius.circular(80.0),
            ),

              ),
              Text("Select a State",
              style: TextStyle(fontSize: 45),
             ),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                value: _selectedCompany,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItem,
              ),
              SizedBox(
                height: 20.0,
              ),

              Text('Selected State Id: ${_selectedCompany.id}',
                style: TextStyle(fontSize: 25),),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, _selectedCompany.id);
                },
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.red)),
                child: Text(
                  'COVID-19 UPDATE',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
