import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smokeapp/header.dart';

class SpotForm extends StatefulWidget {
  @override
  _SpotFormState createState() => _SpotFormState();
}

class _SpotFormState extends State<SpotForm> {
  String _name;
  bool _onlyCustomer = false;
  String _pinsColor = '2';
  bool _isIndoor = false;
  bool _isSeparated = false;
  bool _existsRoof = false;
  bool _existsBench = false;
  String _remarks;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // キーボード外をタップしてキーボードを閉じるメソッド
  void _closeKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // スポット名入力欄
  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'スポット名',
        labelStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'スポット名は必ず入力して下さい';
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  // 店舗利用者のみチェックボックス
  Widget _checkOnlyCustomer() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _onlyCustomer,
          onChanged: (bool value) {
            setState(() {
              _onlyCustomer = value;
              _pinsColor = value ? '1' : '2';
            });
          },
        ),
        Text(
          '店舗利用者のみ\n(選択するとピンの色が変わります)',
          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }

  // 屋内チェックボックス
  Widget _checkIsIndoor() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _isIndoor,
          onChanged: (bool value) {
            setState(() {
              _isIndoor = value;
            });
          },
        ),
        Text(
          '屋内',
          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }

  // 分煙チェックボックス
  Widget _checkIsSeparated() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _isSeparated,
          onChanged: (bool value) {
            setState(() {
              _isSeparated = value;
            });
          },
        ),
        Text(
          '分煙',
          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }

  // 屋根チェックボックス
  Widget _checkExistsRoof() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _existsRoof,
          onChanged: (bool value) {
            setState(() {
              _existsRoof = value;
            });
          },
        ),
        Text(
          '屋根',
          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }

  // ベンチチェックボックス
  Widget _checkExistsBench() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: _existsBench,
          onChanged: (bool value) {
            setState(() {
              _existsBench = value;
            });
          },
        ),
        Text(
          'ベンチ',
          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }

  // 備考入力欄
  Widget _buildRemarks() {
    return TextFormField(
      maxLines: 4,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: '備考',
        labelStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
      onSaved: (String value) {
        _remarks = value;
//        print(_remarks);
      },
    );
  }

  // キャンセルボタン押下時に発動するメソッド
  void _showCancelConfirmDialog() async {
    var result = await showDialog<int>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('確認'),
          content: Text('入力を破棄してマップに戻りますか？'),
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
  }

  @override
  Widget build(BuildContext context) {
    // キーボード使用中に画面タップでキーボードを閉じる
    // その為にはScaffoldをGestureDetectorでラップする
    return GestureDetector(
      onTap: _closeKeyBoard,
      child: Scaffold(
        appBar: Header(headerText: 'スポットの詳細情報を入力'),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
//        color: Colors.red,
            padding: EdgeInsets.only(top: 35.0, left: 30.0, right: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                // 上部から配置する
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildName(),
                  SizedBox(height: 30.0),
                  _checkOnlyCustomer(),
                  _checkIsIndoor(),
                  _checkIsSeparated(),
                  _checkExistsRoof(),
                  _checkExistsBench(),
                  _buildRemarks(),
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
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        print(_name);
                        print(_onlyCustomer);
                        print(_pinsColor);
                        print(_isIndoor);
                        print(_isSeparated);
                        print(_existsRoof);
                        print(_existsBench);
                        print(_remarks);
                      },
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
                      onPressed: _showCancelConfirmDialog,
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
          ),
        ),
      ),
    );
  }
}
