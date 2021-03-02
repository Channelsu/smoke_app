import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smokeapp/spot_detail.dart';

class FavPage extends StatefulWidget {
  @override
  _FavPageState createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  var listItem = ['one', 'two', 'three'];

  // リスト一行タップ時に発動するメソッド
  void _showSpotDetail() async {
    // スポット詳細画面へ遷移処理
    await Navigator.push(
      context,
      CupertinoPageRoute(
        // 場所詳細画面への遷移
        builder: (context) => SpotDetail(),
      ),
    );
  }

  // スポットアイコン押下時に発動するメソッド
  void _jumpToTheSpot() {
    // トップ画面(マップ画面)に遷移する処理記述
  }

  // ゴミ箱アイコン押下時に発動するメソッド
  void _showDeleteConfirmDialog() async {
    // 削除確認ダイアログを表示させる処理記述
    var result = await showDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('確認'),
          content: Text('お気に入りから削除します。\nよろしいですか？'),
          actions: <Widget>[
            FlatButton(
              child: Text('はい'),
              onPressed: () => {
                // お気に入りからの削除処理
                setState(() {}),
                Navigator.pop(context),
              },
            ),
            FlatButton(
              child: Text('いいえ'),
              onPressed: () => {
                Navigator.pop(context),
              },
            ),
          ],
        );
      },
    );
    print('fav delete dialog result: $result');
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
              // title: Text('$index'),
              title: Text('ファミリーマート'),
              subtitle: Text('東京都/新宿区'),
              onTap: _showSpotDetail,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // スポットアイコン
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 38.0, // you can adjust the width as you need
                    child: IconButton(
                      icon: Icon(
                        Icons.place,
                        color: Colors.brown[900],
                      ),
                      onPressed: _jumpToTheSpot,
                    ),
                  ),
                  // ゴミ箱アイコン
                  Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 38.0, // you can adjust the width as you need
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.brown[900],
                      ),
                      onPressed: _showDeleteConfirmDialog,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
