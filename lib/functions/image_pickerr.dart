import 'dart:io';

import 'package:image_picker/image_picker.dart' as imgPick;

Future<File> pickAnImage()async{
  File _image ;
  imgPick.PickedFile  pickedFile =await imgPick.ImagePicker().getImage(source: imgPick.ImageSource.camera );
  if(pickedFile != null){
    _image = File(pickedFile.path);
    return _image ;
  }
  return null ;

}