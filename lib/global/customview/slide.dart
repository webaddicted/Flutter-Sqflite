import 'package:flutter/material.dart';
import 'package:fluttersqflite/global/constant/assets_constant.dart';
import 'package:fluttersqflite/global/constant/string_constant.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: AssetsConstant.SLIDER1_IMG,
    title: 'A Cool Way to Get Start',
    description: StrConstant.DUMMY_TEXT
  ),
  Slide(
    imageUrl: AssetsConstant.SLIDER2_IMG,//'assets/images/image2.jpg',
    title: 'Design Interactive App UI',
    description: StrConstant.DUMMY_TEXT
  ),
  Slide(
    imageUrl: AssetsConstant.SLIDER3_IMG,//'assets/images/image3.jpg',
    title: 'It\'s Just the Beginning',
    description: StrConstant.DUMMY_TEXT
  ),
];
