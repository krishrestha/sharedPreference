import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double balance = 0 ;

  void addMoney() async{
    setState(() {
      balance =balance + 0.5 ;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('balance', balance);
  }

  @override
  void initState() {
    loadBalance();
    super.initState();
  }

  void loadBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      balance = prefs.getDouble('balance') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Shared Preference'),centerTitle: true,),
        body: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(flex: 9,child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your Balance'),
                  Text('\$ $balance'),
                ],
              )),
              Expanded(flex: 1,child: ElevatedButton(onPressed: addMoney, child: Text('Add Money'),style:ElevatedButton.styleFrom(minimumSize: Size(double.infinity,0)),))
            ],
          ),
        ),
      ),
    );
  }
}
