import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  //インスタンスを生成する際、引数を受け取って代入する変数を定義
  final String headerText;
  //受け取る値を上記の変数に代入(コンストラクタ)
  Header({this.headerText});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(42.0), // here the desired height
      child: AppBar(
        centerTitle: true,
        title: Text(this.headerText),
      ),
    );
  }
}
