import 'package:bloc_demo/Api/api.dart';
import 'package:flutter/material.dart';

import '../comman.dart';


class postapi extends StatefulWidget {
  const postapi({Key? key}) : super(key: key);

  @override
  State<postapi> createState() => _postapiState();
}

class _postapiState extends State<postapi> {
  TextEditingController name = TextEditingController();
  TextEditingController job = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProgressLoader pl = ProgressLoader(context, isDismissible: false);
    return Scaffold(
      appBar: AppBar(
          title: Text('Post Api'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent),
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 100,),
              TextField(
                controller: name,
                decoration:
                InputDecoration(border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: job,
                decoration:
                InputDecoration(border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
              ),
              ElevatedButton(onPressed: () {
                api.post(name.text, job.text, pl);
              }, child: Text('Add'))
            ],
          )),
    );
  }
}
