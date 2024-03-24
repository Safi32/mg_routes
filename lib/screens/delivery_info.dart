import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mg_routes/screens/qr_code_screen.dart';
import 'package:mg_routes/utils/colors.dart';
import 'package:mg_routes/widgets/title_des_widget.dart';

class DeliveryInfo extends StatefulWidget {
  const DeliveryInfo({super.key});

  @override
  State<DeliveryInfo> createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  bool flag = false;
  bool flag1 = false;
  bool flag2 = false;
  bool flag3 = false;
  List<File> _images = [];

  void _selectImages() async {
    final XFile? picture =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (picture != null) {
      setState(() {
        _images.add(File(picture.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: Colors.black87,
      child: Stack(
        children: [
          Image.asset(
            "assets/Background image.png",
          ),
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.grey.shade800),
            child: Center(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => linearGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: const Text(
                      "GCGKh92129",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height * .7,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 41, 41, 41)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Delivery Details",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ExpansionTile(
                            collapsedBackgroundColor: Colors.grey.shade800,
                            backgroundColor: Colors.white,
                            onExpansionChanged: (value) {
                              setState(() {
                                flag = value;
                              });
                            },
                            leading: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  gradient: linearGradient),
                              child: Center(
                                child: Text(
                                  "1",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            title: Text(
                              "Delivery Details",
                              style: TextStyle(
                                  color: flag ? Colors.black : Colors.white,
                                  fontSize: 14),
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 200,
                                child: ListView.builder(
                                  itemBuilder: (context, index) => Container(
                                    child: Column(
                                      children: [
                                        Container(
                                            width: size.width,
                                            decoration: BoxDecoration(
                                                gradient: linearGradient),
                                            child: Text(
                                              "Route # ${index + 1}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TitleSubWidget("Pickup Location",
                                                "House 1, Islamabad"),
                                            TitleSubWidget("Delivery Location",
                                                "House 2, Islamabad"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TitleSubWidget("Pickup Date",
                                                "House 1, Islamabad"),
                                            TitleSubWidget("Delivery Date",
                                                "House 1, Islamabad"),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 7,
                                        )
                                      ],
                                    ),
                                  ),
                                  itemCount: 2,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          ExpansionTile(
                            collapsedBackgroundColor: Colors.grey.shade800,
                            backgroundColor: Colors.white,
                            onExpansionChanged: (value) {
                              setState(() {
                                flag1 = value;
                              });
                            },
                            leading: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  gradient: linearGradient),
                              child: Center(
                                child: Text(
                                  "2",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            title: Text(
                              "Package Details",
                              style: TextStyle(
                                  color: flag1 ? Colors.black : Colors.white,
                                  fontSize: 14),
                            ),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                direction: Axis.vertical,
                                children: [
                                  TitleSubWidget("Package Name", "123456"),
                                  TitleSubWidget("Description", "123456")
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          ExpansionTile(
                            collapsedBackgroundColor: Colors.grey.shade800,
                            backgroundColor: Colors.white,
                            onExpansionChanged: (value) {
                              setState(() {
                                flag2 = value;
                              });
                            },
                            leading: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  gradient: linearGradient),
                              child: Center(
                                child: Text(
                                  "3",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            title: Text(
                              "Photos and QR Code",
                              style: TextStyle(
                                  color: flag2 ? Colors.black : Colors.white,
                                  fontSize: 14),
                            ),
                            children: [
                              Text(
                                "Take Photos of Package",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 12),
                                child: GestureDetector(
                                  onTap: _selectImages,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey.shade700,
                                      ),
                                      Text(
                                        "Take Photos",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      _images.isEmpty
                                          ? Center(
                                              child: Text(''),
                                            )
                                          : Container(
                                              width: 250,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children:
                                                      _images.map((image) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Image.file(
                                                        image,
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Scan QR Code",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 12),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                QRViewExample()));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.qr_code_scanner,
                                        color: Colors.grey.shade700,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("QR Code Details")
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          ExpansionTile(
                            collapsedBackgroundColor: Colors.grey.shade800,
                            backgroundColor: Colors.white,
                            onExpansionChanged: (value) {
                              setState(() {
                                flag3 = value;
                              });
                            },
                            leading: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  gradient: linearGradient),
                              child: Center(
                                child: Text(
                                  "4",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            title: Text(
                              "Signature",
                              style: TextStyle(
                                  color: flag3 ? Colors.black : Colors.white,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
