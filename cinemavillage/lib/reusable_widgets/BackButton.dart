import 'package:flutter/material.dart';

class BackButton1 extends StatelessWidget {
  const BackButton1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.only(
        top: 16,
        left: 16,
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(25, 0, 0, 0),
          borderRadius: BorderRadius.circular(10)),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_rounded),
      ),
    );
  }
}
