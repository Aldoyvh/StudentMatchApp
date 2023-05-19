import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'package:prueba/HomeScreen.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final c_email = TextEditingController();
  final c_password = TextEditingController();
  final c_name = TextEditingController();
  final c_university = TextEditingController();

  String password = "";
  String email = "";
  String name = "";
  String university = "";

  Future ingresar_registro() async{

    var url = Uri.parse("https://aldoyvh.devkishikun.com/phpclass/registro.php");

    var response = await http.post(url,
        body: {
          'correo': email,
          'pass': password,
          'username': name,
          'university': university,
        }
    ).timeout(Duration(seconds: 90));

    String res = response.body;

    if(res == '1'){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context){
            return HomeScreen();}));
    }
    else {
      print(res);
    }
    print(res);
  }

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
                Image.asset('assets/uni.png', scale: 25),
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
                  '¡Bienvenido al Tinder Universitario!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
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
                          hintText: 'Email',
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
                        controller: c_name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Nombre',
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
                        controller: c_university,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Universidad',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: TextButton(
                    onPressed: () {
                      setState((){
                        password = c_password.text;
                        email = c_email.text;
                        name = c_name.text;
                        university = c_university.text;
                      });

                      ingresar_registro();

                      c_password.text = '';
                      c_email.text = '';
                      c_name.text = '';
                      c_university.text = '';
                      if(password=='')
                      {
                        alerta('Completa los datos para continuar');
                        c_password.text=('');
                      }
                      else if(email=='')
                      {
                        alerta('Completa los datos para continuar');
                        c_email.text=('');
                      }
                      else if(name=='')
                      {
                        alerta('Completa los datos para continuar');
                        c_name.text=('');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          "Registrate",
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
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text(
                      '¿Ya tienes una cuenta?  ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context){
                              return LogIn();}));
                      },
                      child: Text("Entra",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 15,
                        ),
                      ),
                    )
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
