import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'dots_indicator.dart';

class CustomImageSlider extends StatefulWidget {
  final List<String> images;
  final double height;

  const CustomImageSlider({Key key, @required this.images, this.height = 200})
      : super(key: key);

  @override
  _CustomImageSliderState createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (_) => true,
      child: Container(
        height: widget.height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                itemBuilder: (BuildContext context, int index) {
                  return CachedNetworkImage(
                    imageUrl: widget.images[index],
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    imageBuilder: (context, imageProvider) => Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                },
              ),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DotsIndicator(
                  controller: _pageController,
                  color: Colors.white,
                  itemCount: widget.images.length,
                  onPageSelected: (int index) {
                    _pageController.animateTo(
                      index.toDouble(),
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOutCirc,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
