import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imageList;

  const ImageSwipe({Key key, this.imageList}) : super(key: key);
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      height: 400,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for (var i = 0; i < widget.imageList.length; i++)
                Container(
                  child: Image.network(
                    '${widget.imageList[i]}',
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    width: _selectedPage == i ? 25 : 12,
                    height: 12,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(12)),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
