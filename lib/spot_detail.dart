import 'package:flutter/material.dart';
import 'package:smokeapp/header.dart';

class SpotDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: '詳細'),
      body: Center(
        child: Container(
          child: Text('スポット詳細'),
        ),
      ),
    );
  }
}
