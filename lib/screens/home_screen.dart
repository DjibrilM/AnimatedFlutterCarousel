import 'package:carousel/widgets/carousel.dart';
import 'package:carousel/widgets/focusAware.dart';
import 'package:carousel/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

const List<String> reactEmojis = [
  '👍', // Like
  '❤️', // Love
  '😂', // Funny
  '😮', // Wow
  '😢', // Sad
  '🙌', // Celebration
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isFocused = false;
  TextEditingController controller = TextEditingController();
  FocusNode inputFoccusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: SafeArea(
            child: Column(
          spacing: 15,
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      inputFoccusNode.unfocus();
                      _isFocused = false;
                    });
                  },
                  child: AnimatedScale(
                    scale: _isFocused ? 0.95 : 1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Carousel(),
                  )),
            )),
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedPositioned(
                    right: 0,
                    left: 0,
                    duration: Duration(milliseconds: 200),
                    top: _isFocused ? -80 : 5,
                    child: AnimatedOpacity(
                      opacity: _isFocused ? 1 : 0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      child: Center(
                        child: AnimatedScale(
                          scale: _isFocused ? 1 : 0.8,
                          duration: Duration(milliseconds: 200),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 66,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 29, 29, 36),
                                borderRadius: BorderRadius.circular(100)),
                            child: Row(
                              spacing: 20,
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    child: Row(
                                      spacing: 20,
                                      children: [
                                        ...reactEmojis.map((element) => Text(
                                              element,
                                              style: TextStyle(fontSize: 30),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            26, 253, 253, 255),
                                        borderRadius:
                                            BorderRadius.circular(1000)),
                                    child: Icon(
                                      TablerIcons.chevron_down,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
                Positioned(
                  child: AnimatedPadding(
                    duration: Duration(milliseconds: 500),
                    padding:
                        EdgeInsets.symmetric(horizontal: _isFocused ? 5 : 20),
                    curve: Curves.bounceOut,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isFocused = true;
                        });
                      },
                      child: FocusAware(
                        onFocusChange: (isFocuded) => {
                          setState(() {
                            _isFocused = isFocuded;
                          })
                        },
                        child: AnimatedContainer(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          duration: Duration(milliseconds: 500),
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            spacing: 7,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LucideIcons.paperclip,
                              ),
                              Expanded(
                                child: Material(
                                  color: Colors.transparent,
                                  child: TransparentInput(
                                    focusNode: inputFoccusNode,
                                    controller: controller,
                                    onTap: () {
                                      setState(() {
                                        _isFocused = true;
                                      });
                                    },
                                    onTapOut: (_) {
                                      setState(() {
                                        _isFocused = true;
                                      });
                                    },
                                    onChanged: (_) {},
                                  ),
                                ),
                              ),
                              Icon(
                                LucideIcons.mic,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                LucideIcons.smile,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
