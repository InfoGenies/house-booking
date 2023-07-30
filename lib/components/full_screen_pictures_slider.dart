


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_booking/data/api/api.dart';

import '../models/picture.dart';
import 'Blur_Widget.dart';

class FullscreenPicturesSlider extends StatelessWidget {
  const FullscreenPicturesSlider(this.pictures);
  final List<Picture> pictures;

  @override
  Widget build(BuildContext context) {
    return BlurWidget(
      child: Builder(
        builder: (context) {
          return Hero(
            tag: 'PictureSlider',
            child: CarouselSlider.builder(
              options: CarouselOptions(
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                enableInfiniteScroll: pictures.length > 1,
                height: Get.height,
              ),
              itemCount: pictures.length,
              itemBuilder: (_, index, index2) => InteractiveViewer(
                panEnabled: false, // Set it to false
                boundaryMargin: const EdgeInsets.all(100),
                minScale: 0.9,
                maxScale: 2,
                child: SizedBox(
                  height: Get.height,
                  child: Center(
                    child: Image.network(
                     baseUrl + pictures[index].picture,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}