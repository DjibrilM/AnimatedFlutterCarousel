import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

const CAROUSEL_IMAGES = [
  "assets/img/image.jpg",
  "assets/img/img1.jpg",
  "assets/img/img2.jpg",
  "assets/img/img3.jpg",
  "assets/img/img4.jpg"
];

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late final ScrollController _controller;
  bool _isScrolling = false;
  int _currentIndex = 0;

  void _handleControllerNotification() {}

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_handleControllerNotification);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: Colors.white10)),
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              Positioned.fill(
                  child: NotificationListener<ScrollEndNotification>(
                      onNotification: (notfication) {
                        setState(() {
                          _isScrolling = false;
                        });
                        return true;
                      },
                      child: SingleChildScrollView(
                          controller: _controller,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...CAROUSEL_IMAGES
                                  .asMap()
                                  .entries
                                  .map((entry) => CarouselElement(
                                        current: _currentIndex,
                                        index: entry.key, // ← this is the index
                                        image: entry
                                            .value, // ← this is the element
                                        constraints: constraints,
                                      ))
                            ],
                          )))),
              Positioned.fill(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    opacity: _isScrolling ? 1 : 0,
                    duration: Duration(milliseconds: 200),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(color: Colors.transparent),
                    ),
                  )),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(6, 0, 0, 0),
                            Color.fromARGB(153, 0, 0, 0)
                          ],
                          stops: [0.25, 0.6],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        spacing: 10,
                        children: [
                          ...CAROUSEL_IMAGES.asMap().entries.map((entry) =>
                              GestureDetector(
                                onTap: () {
                                  if (_currentIndex == entry.key) return;
                                  setState(() {
                                    _isScrolling = true;
                                    _currentIndex = entry.key;
                                  });

                                  _controller.animateTo(
                                      _currentIndex * constraints.maxWidth,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  width: entry.key == _currentIndex ? 95 : 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: entry.key == _currentIndex
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.transparent),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9.8),
                                    child: Image.asset(
                                      entry.value,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                        child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).colorScheme.primary),
                      child: Icon(
                        TablerIcons.x,
                        color: Colors.black,
                        size: 15,
                      ),
                    )),
                  ))
            ],
          );
        }));
  }
}

// ignore: must_be_immutable
class CarouselElement extends StatelessWidget {
  final String image;
  final int index;
  int current;
  BoxConstraints constraints;
  CarouselElement(
      {super.key,
      required this.current,
      required this.constraints,
      required this.image,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned(
              child: AnimatedScale(
                duration: Duration(milliseconds: 300),
                scale: current == index ? 1.2 : 1,
                child: Image.asset(
                  image,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
