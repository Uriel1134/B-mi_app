import 'package:flutter/material.dart';

class VectorHeader extends StatelessWidget {
  const VectorHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Image.asset(
        'assets/images/Vector 1.png',
        fit: BoxFit.fill,
        height: MediaQuery.of(context).size.height * 0.15,
      ),
    );
  }
} 