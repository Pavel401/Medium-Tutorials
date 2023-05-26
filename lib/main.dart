import 'package:capture_widget/widget_to_image.dart';
import 'package:flutter/material.dart';
// ignore_for_file: camel_case_types

import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:social_share/social_share.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home(),
      );
    });
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          WidgetToImage.createImageFromWidget(
            shareComponent(),
            wait: Duration(seconds: 1),
            imageSize: Size(50.w, 20.h),
            logicalSize: Size(50.w, 20.h),
          ).then((Uint8List? imageBytes) async {
            if (imageBytes != null) {
              final tempDir = await getExternalStorageDirectory();

              final file =
                  await new File('${tempDir!.path}/shareImage.png').create();
              await file.writeAsBytes(imageBytes);
              await Share.shareXFiles([XFile(file.path)],
                  text: "Converted image using widget to image");
            } else {
              // Handle the case when image conversion fails
            }
          });
        },
        child: const Icon(Icons.save_outlined),
      ),
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: shareComponent(),
      ),
    );
  }

  Widget shareComponent() {
    return Container(
      margin: EdgeInsets.all(10),
      height: 20.h,
      width: 50.w,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Widget to image ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          FlutterLogo(
            size: 50,
          ),
        ],
      ),
    );
  }
}
