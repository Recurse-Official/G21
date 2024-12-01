import 'package:flutter/material.dart';
import 'package:stash_fund/services/geminiService.dart';
import 'package:stash_fund/services/goalService.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Single Button Example"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async{
              // Define the action for the button here
              var gem= GeminiService();
              var oiut=await gem.generateContent("6749954e5c6f1e3fc91d100f",'Movies','cumulative');
              print(oiut);
            },
            child: Text("Press Me"),
          ),
        ),
      ),
    );
  }
}
