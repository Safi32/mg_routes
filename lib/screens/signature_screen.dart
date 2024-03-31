import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class SignatureScreen extends StatelessWidget {
  SignatureScreen({super.key});
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
  ui.Image? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, left: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context, image);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 100),
            Center(
              child: Container(
                color: Colors.black54,
                child: SfSignaturePad(
                  key: _signaturePadKey,
                  minimumStrokeWidth: 1,
                  maximumStrokeWidth: 3,
                  strokeColor: Colors.black,
                  backgroundColor: Colors.grey.shade400,
                ),
                height: 200,
                width: 300,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: Text("Save As Image"),
                    onPressed: () async {
                      image = await _signaturePadKey.currentState!.toImage();
                    }),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    child: Text("Clear"),
                    onPressed: () async {
                      _signaturePadKey.currentState!.clear();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
