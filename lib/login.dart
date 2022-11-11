import 'package:attendance_dbms/home.dart';
import 'package:attendance_dbms/mongodb.dart';
import 'package:flutter/material.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key}) : super(key: key);

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var log = "LOGIN";

  login() async{
    bool check = await MongoDatabase.loginpage(email.text,password.text);
    if(check == true) {
      log = "LOGIN";
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    }
    else{
      setState(() {
        log = "Login Again";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Center(child: Text("Login Page",style: TextStyle(color: Colors.white),)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 100,),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.deepPurple, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  login();
                },
                child: Text(
                  log,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
