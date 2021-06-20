import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List productSize;
  final Function(String) onSelected;

  const ProductSize({Key key, this.productSize, this.onSelected})
      : super(key: key);

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 12),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < widget.productSize.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected('${widget.productSize[i]}');
                setState(
                  () {
                    _selected = i;
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                constraints: BoxConstraints(
                  minWidth: 42,
                ),
                height: 42,
                decoration: BoxDecoration(
                  color: _selected == i
                      ? Theme.of(context).accentColor
                      : Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${widget.productSize[i]}',
                  style: TextStyle(
                      fontSize: 16,
                      color: _selected == i ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
