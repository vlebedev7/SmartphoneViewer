import 'package:flutter/material.dart';
import './phone_api.dart';
import './models/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smartphone Viewer',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Smartphone Viewer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _optionsExpanded = false;
  String brandName;
  List<Phone> _phones = <Phone>[
    new Phone('AFagsge ggs'),
    new Phone('Gsrhdrh dr')
  ];
  List<String> _brands = const [
    "Acer",
    "Alcatel",
    "Apple",
    "Asus",
    "Blackberry",
    "Google",
    "Honor",
    "HTC",
    "Huawei",
    "Lenovo",
    "LG",
    "Meizu",
    "Microsoft",
    "Motorola",
    "Nokia",
    "Oneplus",
    "Oppo",
    "Samsung",
    "Sony",
    "Vivo",
    "Xiaomi",
    "Zte"
  ];

  void _onClickFind() {
    var phones = PhoneApi.getPhones(SearchSettings(brandName ?? ''));
    setState(() {
      _phones = phones;
      _optionsExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DropdownButton<String>(
                    style: Theme.of(context).textTheme.display1,
                    hint: Text('Brand name'),
                    value: null,
                    onChanged: (newVal) {
                      setState(() {
                        brandName = newVal;
                      });
                    },
                    items: _brands.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                  ),
                  RaisedButton(
                    color: Colors.deepOrange,
                    textTheme: ButtonTextTheme.primary,
                    onPressed: () {},
                    child: Text('Find', textScaleFactor: 1.5),
                  )
                ],
              ),
              Visibility(
                maintainAnimation: true,
                maintainState: true,
                visible: _optionsExpanded,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Checkbox(
                        value: false,
                        onChanged: (_) {},
                      ),
                      Text('Setting'),
                    ]),
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  setState(() {
                    _optionsExpanded = !_optionsExpanded;
                  });
                },
                child: Text(_optionsExpanded ? 'Hide options' : 'More options'),
              ),
              Expanded(
                child: ListView(
                  children: _phones
                      .map((ph) => Card(
                            child: Text(ph.title),
                          ))
                      .toList(),
                ),
              ),
            ]),
      ),
    );
  }
}
