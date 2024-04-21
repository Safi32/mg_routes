import 'package:flutter/material.dart';
import 'package:mg_routes/api/api.dart';
import 'package:mg_routes/screens/delivery_info.dart';
import 'package:mg_routes/utils/colors.dart';
import 'package:mg_routes/widgets/progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../deliveryModel.dart';
import '../packageModel.dart';

enum ListType {
  pickup,
  enroute,
  delivered,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  List<Package> packagesList = [];
  ListType listType = ListType.pickup;
  bool isLoading = false;
  bool isDataLoading = false;
  Package? pack;
  DeliveryResponse? deliveryData;

  @override
  void initState() {
    _fetchList("PICKUP");
    if (packagesList.isNotEmpty) {
    } else {}
    super.initState();
  }

  void getDeliveryData(Package p) async {
    setState(() {
      isDataLoading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await ApiService.get(context,
          "order/${p.orderTrackingNumber}/package/${p.packageTrackingNumber}/details");
      if (response['success'] == true) {
        setState(() {
          deliveryData = DeliveryResponse.fromJson(response);
          print(deliveryData);
          isDataLoading = false;
        });
        pack = p;
      }
    } catch (c) {}
  }

  Future<void> _fetchList(String type) async {
    setState(() {
      isLoading = true;
      packagesList = [];
    });
    try {
      final response =
          await ApiService.get(context, "order/driver/packages/$type");
      print(response.toString());
      PackageDataList packagesData = PackageDataList.fromJson(response);
      setState(() {
        packagesList = packagesData.data;
      });

      print(packagesData.data);
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          color: Colors.black87,
          child: Column(children: [
            Stack(
              children: [
                Image.asset(
                  "assets/Background image.png",
                ),
                Container(
                  height: size.height,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Wrap(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            AssetImage("assets/Home Icon.png"),
                                        radius: 23,
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    "assets/logoHome.png",
                                    width: 170,
                                  ),
                                  SizedBox(),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: size.height * .26,
                              width: size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 47, 47, 47),
                                  borderRadius: BorderRadius.circular(25)),
                              child: isDataLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : deliveryData == null
                                      ? Center(
                                          child: Text(
                                              "Press on a package to see it's details",
                                              style: TextStyle(
                                                  color: Colors.white)))
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  listType == ListType.pickup
                                                      ? "Ready for Pick-up"
                                                      : listType ==
                                                              ListType.enroute
                                                          ? "Package is on its way"
                                                          : "Package Delivered",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                Container(
                                                  height: 30,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient:
                                                        reverselinearGradient,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      deliveryData!
                                                          .data.urgencyLevel,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              deliveryData!.data.name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              deliveryData!.data.trackingNumber,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),

                                            const SizedBox(
                                              height: 7,
                                            ),
                                            // Pass double value only, int will give an error

                                            ProgressIndicatorExample(listType ==
                                                    ListType.pickup
                                                ? 0.0
                                                : listType == ListType.enroute
                                                    ? 50.0
                                                    : 100.0),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  deliveryData!
                                                      .data
                                                      .deliveryRouteDTOS[0]
                                                      .pickupLocation
                                                      .address,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                ),
                                                Text(
                                                  deliveryData!
                                                      .data
                                                      .deliveryRouteDTOS[0]
                                                      .deliveryLocation
                                                      .address,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  ((context) =>
                                                                      DeliveryInfo(
                                                                        deliveryInfo:
                                                                            deliveryData!,
                                                                        packageNumber:
                                                                            pack!.packageTrackingNumber,
                                                                      ))),
                                                        );
                                                      },
                                                      child: Text(
                                                        "View Details",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 130,
                                                      child: ListTile(
                                                        horizontalTitleGap: 0,
                                                        contentPadding:
                                                            EdgeInsets.all(0),
                                                        leading: CircleAvatar(
                                                          radius: 14,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "assets/Home Icon.png"),
                                                        ),
                                                        title: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "John Doe",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  "Pharmacy",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 12.0,
                                                                      left: 4),
                                                              child: Icon(
                                                                Icons.verified,
                                                                size: 12,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(35))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8),
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Recent Activities",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Enter your tracking number",
                                        contentPadding:
                                            const EdgeInsets.only(left: 15),
                                        suffixIconConstraints:
                                            BoxConstraints.tight(Size(40, 40)),
                                        suffixIcon: Container(
                                          height: 20,
                                          width: 20,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              gradient: reverselinearGradient,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Image.asset(
                                            "assets/Search Icon.png",
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _fetchList("PICKUP");
                                          listType = ListType.pickup;
                                          deliveryData = null;
                                          setState(() {
                                            _page = 0;
                                          });
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 27,
                                          decoration: BoxDecoration(
                                              gradient: _page == 0
                                                  ? reverselinearGradient
                                                  : null,
                                              border: Border.all(
                                                  width: 1,
                                                  color: _page == 0
                                                      ? Colors.transparent
                                                      : Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Center(
                                              child: Text(
                                            "Pickup",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: _page == 0
                                                    ? Colors.white
                                                    : Colors.grey.shade400),
                                          )),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _fetchList("ENROUTE");
                                          listType = ListType.enroute;
                                          deliveryData = null;

                                          setState(() {
                                            _page = 1;
                                          });
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 27,
                                          decoration: BoxDecoration(
                                              gradient: _page == 1
                                                  ? reverselinearGradient
                                                  : null,
                                              border: Border.all(
                                                  width: 1,
                                                  color: _page == 1
                                                      ? Colors.transparent
                                                      : Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Center(
                                              child: Text(
                                            "En-route",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: _page == 1
                                                    ? Colors.white
                                                    : Colors.grey.shade500),
                                          )),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _fetchList("DELIVERED");
                                          listType = ListType.delivered;
                                          deliveryData = null;

                                          setState(() {
                                            _page = 2;
                                          });
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 27,
                                          decoration: BoxDecoration(
                                              gradient: _page == 2
                                                  ? reverselinearGradient
                                                  : null,
                                              border: Border.all(
                                                  width: 1,
                                                  color: _page == 2
                                                      ? Colors.transparent
                                                      : Colors.grey.shade400),
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Center(
                                              child: Text(
                                            "Delivered",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: _page == 2
                                                    ? Colors.white
                                                    : Colors.grey.shade500),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 260,
                                    child: isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : packagesList.isEmpty
                                            ? Center(
                                                child: Text("No packages!"))
                                            : ListView.separated(
                                                separatorBuilder:
                                                    (context, index) {
                                                  return Divider(
                                                    color: Colors.black,
                                                  );
                                                },
                                                itemBuilder: (context, index) {
                                                  Package package =
                                                      packagesList[index];
                                                  return GestureDetector(
                                                    onTap: () =>
                                                        getDeliveryData(
                                                            package),
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.blue,
                                                          radius: 20,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "assets/Ready for Pickup icon.png")),
                                                      title: Text(
                                                        package
                                                            .orderTrackingNumber
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12),
                                                      ),
                                                      subtitle: Text(
                                                        "${package.pickupAddress} -> ${package.deliveryAddress}",
                                                        style: TextStyle(
                                                            fontSize: 8),
                                                      ),
                                                      trailing: SizedBox(
                                                        width: 70,
                                                        child: Row(children: [
                                                          Text(
                                                            listType ==
                                                                    ListType
                                                                        .pickup
                                                                ? "Ready"
                                                                : listType ==
                                                                        ListType
                                                                            .enroute
                                                                    ? "Enroute"
                                                                    : "Delivered",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .keyboard_arrow_right,
                                                            size: 34,
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                itemCount: 4,
                                              ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ])),
    );
  }
}
