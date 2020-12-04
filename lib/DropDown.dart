import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DropDownPage(), theme: ThemeData(fontFamily: 'Nunito'));
  }
}

class DropDownPage extends StatefulWidget {
  @override
  _DropDownPageState createState() => _DropDownPageState();
}

class _DropDownPageState extends State<DropDownPage> {
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
        appBar: AppBar(title: Text('drop down')),
        body: ListView(
          children: <Widget>[
            Container(
              width: 100,
              child: DropdownButton(
                value: _selectedCompany,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItem,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text('Selected: ${_selectedCompany.name}'),
          ],
        ));
  }
}

class Company {
  String name;

  Company(this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company('Apple'),
      Company('Google'),
      Company('Samsung'),
      Company('Sony'),
      Company('LG'),
    ];
  }
}
