import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_auth/utils/extensions.dart';

import '../controller/home_controller.dart';

class DisplayPayloadScreen extends StatelessWidget {
  const DisplayPayloadScreen({super.key, this.name, this.phoneNumber, this.id});

  final String? name, phoneNumber;
  final int? id;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController())..getData();
    return Scaffold(
      appBar: AppBar(title: const Text("Display Payload Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${homeController.payloadData}',
              style: Get.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            Text('$name'),
            Text('$phoneNumber'),
            Text('$id'),
          ],
        ),
      ),
    );
  }
}

class DisplayMessage1 extends StatelessWidget {
  const DisplayMessage1({super.key, this.name, this.phoneNumber, this.id});

  final String? name, phoneNumber;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Display Message Screen 1")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$name'),
            Text('$phoneNumber'),
            Text('$id'),
          ],
        ),
      ),
    );
  }
}

class DisplayMessage2 extends StatelessWidget {
  const DisplayMessage2({
    super.key,
    this.name,
    this.phoneNumber,
    this.id,
    this.initialIndexParent,
    this.initialIndexChild,
  });

  final String? name, phoneNumber;
  final int? id, initialIndexParent, initialIndexChild;

  @override
  Widget build(BuildContext context) {
    log("initialIndex is: $initialIndexParent");
    return Scaffold(
      appBar: AppBar(title: const Text("Display Message Screen 2")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$name'),
            Text('$phoneNumber'),
            Text('$id'),
            const Gap(16),

            /// tab bar
            DefaultTabController(
                length: 3,
                initialIndex: initialIndexParent ?? 0,
                child: Column(
                  children: [
                    TabBar(tabs: [
                      Text("Tab 1"),
                      Text("Tab 2"),
                      Text("Tab 3"),
                    ]),
                    TabBarView(children: [
                      Container(
                          color: Colors.red,
                          alignment: Alignment.center,
                          child: Text("Tab 1")),
                      Container(
                          color: Colors.orange,
                          alignment: Alignment.center,
                          child: Text("Tab 2")),
                      Container(
                          color: Colors.blueGrey,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: DefaultTabController(
                              length: 5,
                              initialIndex: initialIndexChild ?? 0,
                              child: Column(
                                children: [
                                  TabBar(tabs: [
                                    Text("Sub 1"),
                                    Text("Sub 2"),
                                    Text("Sub 3"),
                                    Text("Sub 4"),
                                    Text("Sub 5"),
                                  ]),
                                  TabBarView(children: [
                                    Container(color: Color(0xffc056ff)),
                                    Container(color: Color(0xff34b5ff)),
                                    Container(color: Color(0xff34f45f)),
                                    Container(color: Color(0xff34fbd6f)),
                                    Container(color: Color(0xffc0f9988)),
                                  ]).expand,
                                ],
                              ),
                            ),
                          )),
                    ]).expand,
                  ],
                )).expand,
          ],
        ),
      ),
    );
  }
}

class DisplayMessage3 extends StatelessWidget {
  const DisplayMessage3({
    super.key,
    this.name,
    this.phoneNumber,
    this.id,
    this.img,
  });

  final String? name, phoneNumber, img;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Display Message Screen 3")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$name'),
            Text('$phoneNumber'),
            Text('$id'),
            if (img != null) Image.network(img!),
          ],
        ),
      ),
    );
  }
}
