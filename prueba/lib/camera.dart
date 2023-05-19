import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:prueba/menu.dart';

class Camera extends StatefulWidget {
  String email;
   Camera(this.email,{Key key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  final picker = ImagePicker();
  File image = null;
  Dio dio = new Dio();

  Future Upload() async{
    try{

      String filename = image.path.split('/').last;

      FormData formData = new FormData.fromMap({
        'file' : await MultipartFile.fromFile(
            image.path, filename: filename
        )
      });

      await dio.post('https://aldoyvh.devkishikun.com/phpclass/upload.php',
          data: formData).then((value){

        if(value.toString() != 1){
          print('la foto se subio');
        }else{
          print('error');
        }

      });

    }catch(e){
      print(e.toString());
    }
  }

  Future Picture(opcion) async{
    var pickedFile;

    if(opcion==1){
      pickedFile = await picker.pickImage(source: ImageSource.camera,
          imageQuality: 50.bitLength,
        maxHeight: 500,
        maxWidth: 500,
      );

    }
    else{
      pickedFile = await picker.pickImage(source: ImageSource.gallery,
          imageQuality: 50.bitLength,
          maxHeight: 500,
          maxWidth: 500
      );
    }
    
    setState(() {
      if(pickedFile != null){
        //image = File(pickedFile.path);
        cortar(File(pickedFile.path));
      }
    });
    
    Navigator.of(context).pop();
  }

  cortar(picked) async{
    CroppedFile cortada = await ImageCropper().cropImage(
        sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ]
    );

    var route = cortada?.path;
    setState(() {
      image = File(route);
    });

  }

  opciones(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Picture(1);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide( width: 1, color:  Colors.lightBlue)
                        )
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Tomar una foto',
                              style: TextStyle(
                                  fontSize: 16),
                            ),
                          ),
                          Icon(Icons.camera_alt_outlined, color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Picture(2);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide( width: 1, color:  Colors.lightBlue)
                          )
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Seleccionar desde la galeria',
                              style: TextStyle(
                                  fontSize: 16),
                            ),
                          ),
                          Icon(Icons.photo, color: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide( width: 1, color:  Colors.lightBlue)
                          )
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(Icons.cancel, color: Colors.red),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
    }
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        backgroundColor: Color(0xffFF0000),
        centerTitle: true,
        title: Text('Perfil',style: TextStyle(
            fontFamily: 'Tinder',
            fontSize: 24
        ),),
      ),
      endDrawer: Menu(),
      body: ListView(
        children: [
          Column(
            children: [
              Text('Bienvenido de vuelta ' + widget.email),
              SizedBox(height: 30),
              image == null ? Image.asset('assets/hombre.jpg', width: 100,):
              Image.file(image, width: 200),
              SizedBox(height: 20),
              ElevatedButton(onPressed: (){
                opciones();
              }, child: Text('Elegir foto')
              ),
              SizedBox(height: 40),
              ElevatedButton(onPressed: (){
                Upload();
              }, child: Text('Subir foto')
              ),
            ],
          )
        ],
      ),
    );
  }
}
