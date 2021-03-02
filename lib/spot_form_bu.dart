import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpotForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(42.0), // here the desired height
          child: AppBar(
            centerTitle: true,
            title: Text('スポットの詳細情報を入力'),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Container(
//              color: Colors.blue,
//              height: 50,
//            ),
            Container(
//              color: Colors.red,
              padding: EdgeInsets.only(top: 35.0, left: 30.0, right: 30.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 45.0),
                  Container(
                    height: 40,
                    // 横幅いっぱいに広げる
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.green,
                      shape: StadiumBorder(),
                      // 影をつける
                      elevation: 7.0,
                      splashColor: Colors.white,
                      onPressed: () {},
                      child: Text(
                        '投稿',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 7.0),
                  Container(
                    height: 40,
                    // 横幅いっぱいに広げる
                    child: FlatButton(
                      shape: StadiumBorder(),
                      onPressed: () async {
                        // フォームのキャンセルボタン押下時のダイアログ------------------------------------
                        var result = await showDialog<int>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
//                              title: Text('確認'),
                              content: Text('入力を破棄してMAPに戻りますか？'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('はい'),
                                  onPressed: () => {
                                    // 矢印が付かないようトップ画面に遷移させる
                                    Navigator.popUntil(context, ModalRoute.withName('/')),
                                  },
                                ),
                                FlatButton(
                                  child: Text('いいえ'),
                                  onPressed: () => Navigator.of(context).pop(1),
                                ),
                              ],
                            );
                          },
                        );
                        print('dialog result: $result');
                        // --------------------------------------------------------------------------
                      },
                      child: Text(
                        'キャンセル',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
