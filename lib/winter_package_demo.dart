library winter_package_demo;

import 'package:flutter/material.dart';

double kScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double kScreenHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

class IndexBar extends StatefulWidget {
  const IndexBar({super.key, required this.onTap});
  final void Function(String letter)? onTap;
  @override
  State<IndexBar> createState() => _IndexBarState();
}

class _IndexBarState extends State<IndexBar> {
  Color _bgColor = Colors.transparent;
  Color _textColor = Colors.black;
  double _indicatorY = 0;
  String _indicatorLetter = "";
  bool _indicatorShow = false;

  int getLetter(BuildContext context, Offset globalPosition) {
    //拿到当前小部件的盒子
    RenderBox box = context.findRenderObject() as RenderBox;
    //获取当前小部件的坐标 ,
    double posY = box.globalToLocal(globalPosition).dy;
    var itemHeight = kScreenHeight(context) / 2 / _letters.length;
    int index = (posY ~/ itemHeight).clamp(0, _letters.length - 1);
    return index;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> words = [];

    for (var i = 0; i < _letters.length; i++) {
      words.add(
        Expanded(
          child: Text(
            _letters[i],
            style: TextStyle(color: _textColor, fontSize: 10),
          ),
        ),
      );
    }
    return Positioned(
      right: 0,
      top: kScreenHeight(context) / 8,
      height: kScreenHeight(context) / 2,
      width: 120,
      child: Row(
        children: [
          Container(
            alignment: Alignment(0, _indicatorY),
            width: 100,
            child:
                _indicatorShow
                    ? Stack(
                      alignment: Alignment(-0.2, 0),
                      children: [
                        Text(
                          _indicatorLetter,
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ],
                    )
                    : null,
          ),
          GestureDetector(
            onVerticalDragDown: (details) {
              setState(() {
                _bgColor = Color.fromRGBO(1, 1, 1, 0.2);
                _textColor = Colors.white;
              });
            },
            onVerticalDragEnd: (details) {
              setState(() {
                _bgColor = Colors.transparent;
                _textColor = Colors.black;
                _indicatorShow = false;
              });
            },
            onVerticalDragUpdate: (details) {
              int letter = getLetter(context, details.globalPosition);
              widget.onTap?.call(_letters[letter]);
              setState(() {
                _indicatorY = 2.2 / _letters.length.toDouble() * letter - 1.1;
                _indicatorLetter = _letters[letter];
                _indicatorShow = true;
              });
            },
            onTapDown: (details) {
              int letter = getLetter(context, details.globalPosition);
              widget.onTap?.call(_letters[letter]);
              setState(() {
                _indicatorY = 2.2 / _letters.length.toDouble() * letter - 1.1;
                _indicatorLetter = _letters[letter];
                _indicatorShow = true;
              });
            },
            child: Container(
              width: 20,
              color: _bgColor,
              child: Column(children: words),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> _letters = [
  '🔍',
  '⭐️',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];
