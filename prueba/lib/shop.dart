import 'package:flutter/material.dart';
import 'package:prueba/menu.dart';

class Shop extends StatefulWidget {
  const Shop({Key key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  void alertaPlat(String mensaje) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('¿Quieres convertirte en platinum?'),
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
              TextButton(onPressed: (){
                
              }, 
                  child: Text('Convertirme en Platinum'))
            ],
          );
        });
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
              TextButton(onPressed: (){

              },
                  child: Text('Convertirme en Plus'))
            ],
          );
        });
  }

  void alertagold(String mensaje) {
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
              TextButton(onPressed: (){

              },
                  child: Text('Convertirme en Gold'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Tienda',style: TextStyle(
            fontFamily: 'Tinder',
            fontSize: 50
        ),),
      ),
      endDrawer: Menu(),
      backgroundColor: Colors.deepOrange,
      body: ListView(
        children: [
          ElevatedButton(onPressed: (){
            alertaPlat('Obtén likes ilimitados, ver a quién le gustas y'
                ' ver otras partes del mundo, además de obtener beneficios mensuales y aparecerás'
                ' más a las otras personas, por solo \$550mxn al mes');
    }, child: Image.asset('assets/platinum.png', width: 150,),
            ),
          SizedBox( height: 40,),
          ElevatedButton(onPressed: (){
            alertagold('Obtén likes ilimitados, ver a quién le gustas y'
                ' ver personas de otras partes del mundo, obtén 5 superlikes al mes'
                ' por solo \$340mxn al mes');
          }, child: Image.asset('assets/gold.png', width: 200,),
          ),
          SizedBox( height: 40,),
          ElevatedButton(onPressed: (){

          }, child: Image.asset('assets/plus.png', width: 200,),
          ),
        ],
      ),
    );
  }
}
