import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prueba/HomeScreen.dart';
import 'package:prueba/password.dart';
import 'signup.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prueba/camera.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final c_email = TextEditingController();
  final c_password = TextEditingController();
  var answer;

  String email = '';
  String password = '';
  String id=  '';
  String username = '';

  void alerta(String mensaje) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Datos incompletos'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(mensaje)
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar')
              ),
            ],
          );
        });
  }

  Future Seedata() async{

    await SharedPreferences.getInstance().then((prefs){
      setState(() {
        id =  prefs.getString('id') ?? '';
        password =  prefs.getString('pass') ?? '';
        email =  prefs.getString('email') ?? '';
        print(id+'--'+password+'--'+email);

        if(id !=  null){
          if(id != ''){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context){
                  return HomeScreen();}));
          }
        }
      });
    });
  }

  Future Logout() async{
    await SharedPreferences.getInstance().then((prefs){
      prefs.clear();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Seedata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/uni.png', scale: 3),
                const Text(
                  'Studymate',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                      fontSize: 38,
                      fontFamily: 'Tinder'
                  ),
                ),
                const SizedBox(height:  10),
                const Text(
                  'Coloca tu cuenta para ingresar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                      fontFamily: 'Tinder'
                  ),
                ),
                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red[100],
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: c_email,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Correo',
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red[100],
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: c_password,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Contraseña',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context){
                          return Password();}));
                  },
                  child: Text("¿Olvidaste tu contraseña?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextButton(
                    onPressed: () {
                      email = c_email.text;
                      password = c_password.text;

                      send_data();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text(
                      '¿Aún no tienes cuenta? ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context){
                              return Register();}));
                      },
                      child: Text("Resgístrate",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> send_data() async {
    var url = Uri.parse("https://aldoyvh.devkishikun.com/phpclass/entrar.php");

    answer = await http.post(url, body: {
      'correo': email,
      'pass': password,
    }).timeout(Duration(seconds: 90));
    var datos = jsonDecode(answer.body);
    print(datos);
    if (datos['respuesta'] == '1'){

      Savedata(datos);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context){
            return HomeScreen();}));
    }
    else{
      alerta('Usuario o contrasena incorrectos');
      print(answer.body);
    }
  }
  Future Savedata(datos) async{
    await SharedPreferences.getInstance().then((prefs){
      prefs.setString('id', datos['id']);
      prefs.setString('email', datos['email']);
      prefs.setString('pass', datos['pass']);
    });
  }

}


