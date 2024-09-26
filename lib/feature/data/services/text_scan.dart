import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class TextScan{
    Future<String> getRecognizer(
    XFile img,
  ) async {
    final selectedImage = InputImage.fromFilePath(img.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognizedText =
        await textRecognizer.processImage(selectedImage);
    await textRecognizer.close();
    return recognizedText.text;
  }
}