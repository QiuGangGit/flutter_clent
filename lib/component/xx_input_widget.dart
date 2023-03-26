import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef XXInputCallback = void Function(String value);

class XXInputWidget extends StatelessWidget {
  final String title;
  final String hintTitle;
  final TextEditingController controller;
  final XXInputCallback voidCallback;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;
  int width;

  XXInputWidget(
      {Key? key,
      required this.title,
      required this.inputFormatters,
      required this.maxLength,
      required this.hintTitle,
      required this.controller,
      this.width = 300,
      required this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: width.toDouble(),
        height: 1,
        color: Color(0xFFF7F7F7),
      ),
      SizedBox(
        width: width.toDouble(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            Container(
              width: width.toDouble()-100,
              height: 50,
              margin: const EdgeInsets.only(left: 40),
              child: TextField(
                autofocus: false,
                controller: controller,
                enableInteractiveSelection: false,
                cursorColor: Colors.black,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                onChanged: (value) {
                  voidCallback(value);
                },
                maxLength: maxLength,
                inputFormatters: inputFormatters,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isCollapsed: false,
                  counterText: '',
                  hintText: hintTitle,
                  hintStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: width.toDouble(),
        height: 1,
        color: Color(0xFFF7F7F7),
      ),
    ]);
  }
}
