import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smokeapp/info_detail_page.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  var listItem = ['one', 'two', 'three'];

  // リスト一行タップ時に発動するメソッド
  void _showInfoDetail() async {
    // 画面遷移処理
    await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => InfoDetailPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listItem.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.star),
              // title: Text('$index'),
              title: Text('喫煙所探訪リリース'),
              subtitle: Text('2020/08/13'),
              onTap: _showInfoDetail,
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}
