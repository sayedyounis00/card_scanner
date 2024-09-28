import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:ocr_app/feature/data/services/image_picker.dart';
import 'package:ocr_app/feature/data/services/text_scan.dart';
import 'package:ocr_app/feature/ui/widget/outptu_card_info.dart';
import 'package:ocr_app/feature/ui/widget/radio_selection.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PickCropImage extends StatefulWidget {
  const PickCropImage({super.key});

  @override
  State<PickCropImage> createState() => _PickCropImageState();
}

class _PickCropImageState extends State<PickCropImage> {
  final TextEditingController cardNumcont = TextEditingController();
  final TextEditingController cardtypeCont = TextEditingController();
  int _selectedOption1 = 0;
  int _selectedOption2 = 0;
  String scannedText = '';
  bool isScanning = false;
  XFile? cropedImage;
  final Map<String, String> companyOption = {
    'اتصالات': '*556*',
    'فودافون': '*858*',
    'اورنج': '*102*',
  };
  final Map<String, String> cardOption = {
    'ميكسات': '1*',
    'دقائق': '2*',
    'انترنت': '3*',
  };

  Future<void> onClicked(ImageSource imageSource) async {
    cropedImage = await ImagePickerServices().pickCropImage(
        imageSource: imageSource,
        cropAspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('اختار صوره'),
          icon: const Icon(Icons.add),
          onPressed: () {
            onClicked(ImageSource.camera);
          }),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: cropedImage != null
                    ? Stack(
                        children: [
                          Image(
                            height: 200,
                            width: 400,
                            image: FileImage(
                              File(cropedImage!.path),
                            ),
                          ),
                          Visibility(
                            visible: isScanning ? true : false,
                            child: RotatedBox(
                              quarterTurns: 0,
                              child:
                                  LottieBuilder.asset('assets/scan_Image.json'),
                            ),
                          ),
                        ],
                      )
                    : const Center(child: Text('NO Image Selected')),
              ),
              const SizedBox(
                height: 10,
              ),
              cropedImage != null
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: RadioSelection(
                                companyOption: companyOption.keys.toList(),
                                selectdOption: _selectedOption1,
                                onChange: (val) {
                                  _selectedOption1 = val!;
                                  setState(() {});
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioSelection(
                                companyOption: cardOption.keys.toList(),
                                selectdOption: _selectedOption2,
                                onChange: (val) {
                                  _selectedOption2 = val!;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isScanning = true;
                              });
                              Future.delayed(
                                const Duration(seconds: 2),
                                () async => await TextScan()
                                    .getRecognizer(cropedImage!)
                                    .then(
                                      (val) => setState(
                                        () {
                                          isScanning = false;
                                        },
                                      ),
                                    ),
                              );
                              cardNumcont.text = scannedText;
                              cardtypeCont.text = companyOption.values
                                      .toList()[_selectedOption1] +
                                  cardOption.values.toList()[_selectedOption2];
                              scannedText =
                                  await TextScan().getRecognizer(cropedImage!);
                            },
                            child: const Text('مسح ضوئي')),
                        OutPutCardInfo(
                          cont1: cardtypeCont,
                          cont2: cardNumcont,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              await launchUrlString(
                                  'tel://${cardtypeCont.text + cardNumcont.text}');
                            },
                            child: const Text('شحن الكارت')),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
