import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';


class interactive extends StatefulWidget {
  const interactive({super.key});

  @override
  State<interactive> createState() => _interactiveState();
}

class _interactiveState extends State<interactive> {


  //variables ho ovaina ny state rehef avy mi-click boutton

  String a = 'Jonathan' ; 
  Color loko_background =Colors.white ;
  Color loko_text = Colors.black ; 
  bool isDark = false ; 
  double alavako = 100.0 ;
  TextEditingController nom = TextEditingController() ;  
  TextEditingController prenom = TextEditingController() ; 

  String selectedSexe = 'Homme';
  
  // Variable des checkbox
  bool isFlutterChecked = false ; 
  bool isJavascriptChecked = false ; 
  String technologie = "" ; 

  //variable de visibilité des résultats
  bool isVisible = false ; 

  //anasiana an le image
  String? path; 
  //fonction pickImage

  final ImageCropper _imageCropper = ImageCropper();

  Future<XFile?> pickImage_cam() async{
    final picker = ImagePicker() ; 
    return await picker.pickImage(source: ImageSource.camera) ; 
  }

  // ignore: non_constant_identifier_names
  Future<String?> Image_cam()async{
    final PickedFile = await pickImage_cam() ; 
    if (PickedFile != null) {
      final croppedFile = await _imageCropper.cropImage(
        sourcePath: PickedFile.path,
        maxWidth: 512, // Largeur maximale du fichier recadré
        maxHeight: 512, // Hauteur maximale du fichier recadré
      );

      if (croppedFile != null) {
        setState(() {
          path = croppedFile.path;
        });
      }
    }
    return null;
  }

  //fonction pickImage
  Future<XFile?> pickImage_gal() async{
    final picker = ImagePicker() ; 
    return await picker.pickImage(source: ImageSource.gallery) ; 
  }

  // ignore: non_constant_identifier_names
  Future<String?> Image_gal()async{
    final PickedFile = await pickImage_gal() ; 
    if (PickedFile != null) {
    final croppedFile = await _imageCropper.cropImage(
      sourcePath: PickedFile.path,
      maxWidth: 512, // Largeur maximale du fichier recadré
      maxHeight: 512, // Hauteur maximale du fichier recadré
    );

    if (croppedFile != null) {
      setState(() {
        path = croppedFile.path;
      });
    }
  }
  return null;
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  

  @override
  void initState() {
    // TODO: implement initState
    a = "claire" ; 
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      
      
     body: Padding(
       padding: const EdgeInsets.all(50.0),
       child: SingleChildScrollView(
         child: Column(
          children: [
            
            //message de bienvenue
            Visibility(
              visible: !isVisible,
              child: const SizedBox(
                width: 300,
                child: Center(
                  child: Text(
                    "Ceci est une application de test" , 
                    style: TextStyle(
                      fontSize: 25 , 
                      color: Colors.blueGrey , 
                      fontWeight:FontWeight.w500 , 
                    ),
                    textAlign: TextAlign.center,
                    
                  ),
                ),
              ),
            ) ,  
            // Input pseudo
            
            Visibility(
              visible: !isVisible,
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: const InputDecoration(
                          label: Text("Nom") , 
                        ),
                        controller: nom,
                      ),
                    ),
                  ) , 
                  
                      // email 
                      Center(
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        decoration: const InputDecoration(
                          label: Text("Prénom") 
                           
                        ),
                        controller: prenom,
                      ),
                    ),
                  ) , 
                      // sexe
                  SizedBox(
                    width: 300,
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Sexe : " , 
                          style: TextStyle(
                            fontSize: 20 , 
                            fontStyle: FontStyle.italic
                          ),
                        ) , 
                        const Text(
                          "H" , 
                          style: TextStyle(
                            //fontSize: 20 , 
                          ),
                        ) , 
                        Radio( 
                          value: "Homme",
                          groupValue: selectedSexe,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSexe = newValue!;
                          });
                          },
                          activeColor: Colors.blue,
                        ),
                   
                        const Text(
                          "F" , 
                          style: TextStyle(
                            //fontSize: 20 , 
                          ),
                        ) , 
                        Radio(
                          value: "Femme",
                          groupValue: selectedSexe,
                          onChanged: (String? newValue) {setState(() {
                            selectedSexe = newValue!;
                          }); 
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                           ),
                   ) , 
                  
                  // Taille
                  
                   SizedBox(
                    width: 300,
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Taille : ' , 
                          style: TextStyle(
                            fontSize: 20 , 
                            fontStyle: FontStyle.italic , 
                          ),
                        ),
                          Slider(
                            value: alavako, // La valeur actuelle du slider
                            onChanged: (double newValue) {
                              setState(() {
                                alavako = newValue ; 
                              });
                              
                            },
                            activeColor: Colors.blue,
                            
                            min: 100.0, // Valeur minimale
                            max: 250.0, // Valeur maximale
                          ),
                                ],
                           ),
                   ) , 

                   //anniversaire
                   SizedBox(
                      width: 300,
                      child:  ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Date d\'anniversaire'),
                    ),
                   ) , 
                  
                  // Technologie
                  SizedBox(
                    width: 300,
                    child: Row(
                  
                      children: [
                        const Text(
                          "Technologie: " , 
                          style: TextStyle(
                            fontSize: 20 , 
                            fontStyle: FontStyle.italic , 
                          ),
                        ) , 
                  
                        // Flutter
                        Column(
                          children: [
                            Row(
                              children: [
                                const Column(
                                  children: [
                                     Text(
                                      "Flutter" , 
                                      style: TextStyle(
                                            fontSize: 15 , 
                                      ),  
                                    ),
                                  ],
                                ) , 
                                Column(
                                children: [
                                  Checkbox(
                                  
                                    value: isFlutterChecked, 
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        isFlutterChecked = newValue! ; 
                                        technologie += "Flutter , " ; 
                                      });
                                    },
                                      
                                    ),
                                ],
                            ),
                              ],
                            ) , 
                            
                            Row(
                              children: [
                                const Text(
                                  "Javascript" , 
                                  style: TextStyle(
                                    fontSize: 15 , 
                                  ),  
                                ) , 
                                Checkbox(
                                
                                  value: isJavascriptChecked, 
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      isJavascriptChecked = newValue! ; 
                                      technologie += "Javascript , " ; 
                                    });
                                  },
                                    
                                  ),
                              ],
                            ),
                  
                          ],
                        ) , 
                  
                      ],
                    ),
                  ) , 
                  
                  //boutton maka image
                    Row(
                      children: [
                        Container(
                           decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 92, 5, 27) ,
                            borderRadius: BorderRadius.all(Radius.circular(10)) , 
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.camera), 
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {
                              // Action à exécuter lorsque l'appareil photo est pressé
                              Image_cam() ; 
                            },
                          ),
                         
                        ),

                        const SizedBox(width: 30,) , 
                        Container(
                           decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 6, 247, 26) ,
                            borderRadius: BorderRadius.all(Radius.circular(10)) , 
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.photo),
                            color: Colors.white,
                            iconSize: 30, // Icône de galerie
                            onPressed: () {
                              // Action à exécuter lorsque la galerie est pressée
                              Image_gal() ; 
                            },
                          ),
                        ),
                      ],
                    ) , 

                  //boutton submit
                  SizedBox(
                    width: 300,
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(Colors.white) , 
                          backgroundColor: MaterialStateProperty.all(Colors.blue) , 
                        ),
                        onPressed: (){
                          setState(() {
                            isVisible = !isVisible ; 
                          });
                        }, 
                        child: const Text("Valider") , 
                      ),
                    ),
                  ),
                ],
              ),
            ) ,
       





            
            //affichage
             Visibility(
              visible: isVisible,
               child: Column(
                children: [

                  
                  //affichage image
                  path!=null ? 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        File(path!) , //chemin an le sary nalaina
                        cacheHeight: 100,
                        cacheWidth: 100,
                      ),
                    )
                  : const Text("Prendre photo") ,
                  //affichage de nom
                  Text(
                      "Pseudo : ${nom.text}" , 
                    ) , 
                         
                  //affichage de prénom
                  Text(
                      "Email : ${prenom.text}" , 
                    ) ,

                  Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      
                  ), 
                  
                  //affichage de sexe 
                  Text(
                      "Sexe : $selectedSexe" , 
                    ) , 
                         
                  //affichage de la taille 
                  Text(
                      "Taille : $alavako" , 
                    ) , 
                         
                  //affichage technologie
                   Text(
                       "Technologies : $technologie" , 
                     ) , 
                  
                    
                  
                         
                ],
              ),
             ) ,        
          ],
        ),
       ),
     ) , 
     
    );
  }
}