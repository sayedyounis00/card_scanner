import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerServices {
  Future<XFile?> pickCropImage(
      {required ImageSource imageSource,
      required CropAspectRatio cropAspectRatio}) async {
    //?pickImage
    XFile? pickImage = await ImagePicker().pickImage(source: imageSource);
    if (pickImage == null) return null;
    CroppedFile? cropedFile = await ImageCropper().cropImage(
      sourcePath: pickImage.path,
      aspectRatio: cropAspectRatio,
      compressQuality: 90,
      compressFormat: ImageCompressFormat.jpg,
    );
    if (cropedFile == null) return null;
    return XFile(cropedFile.path);
  }
}
