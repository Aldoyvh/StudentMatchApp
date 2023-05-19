import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'signup.dart';
import 'package:prueba/HomeScreen.dart';
import 'dart:convert';

class Password extends StatefulWidget {
  const Password({Key key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final c_email = TextEditingController();
  final c_password = TextEditingController();
  final c_name = TextEditingController();
  var answer;

  String email;
  String password;
  String name = "";



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
  Future<void> send_data() async {

    var url = Uri.parse("https://aldoyvh.devkishikun.com/phpclass/entrar.php");
    var datos = jsonDecode(answer.body);
    answer = await http.post(url, body: {
      'correo': email,
      'pass': password,
    }).timeout(Duration(seconds: 90));
    print(datos);

    if (datos['respuesta'] == '1'){

      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context){
            return HomeScreen();}));
    }
    else{
      alerta('datos incorrectos');
      print(answer.body);
    }
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
                Image.asset('assets/uni.png', scale: 3
                ),
                const SizedBox(height: 20),

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
                  'Recupera tu contraseña',
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
                        controller: c_name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nombre',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                          hintText: 'Contraseña',
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
                          hintText: 'Confirmar contraseña',
                        ),
                      ),
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
                      child: Text("Registrate",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 15,
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




}
