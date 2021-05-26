import 'package:flutter/material.dart';
import 'package:smokeapp/fav_page.dart';
import 'package:smokeapp/header.dart';
import 'package:smokeapp/info_page.dart';
import 'package:smokeapp/spot_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/spotform': (context) => SpotForm(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // 表示中の Widget を取り出すための index としての int 型の mutable な stored property
  int _selectedIndex = 1;
  String _headerText = '喫煙所探訪';
  bool _isShowFab = true;

  // 表示する ページ の一覧
  static List<Widget> _pageList = [
//    CustomPage(pannelColor: Colors.cyan, title: 'マップ'),
//    CustomPage(pannelColor: Colors.green, title: 'お気に入り'),
    FavPage(),
    Center(child: Text('地図だよー')),
    InfoPage()
  ];

  // ボトムバーでページ切替時の処理
  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        _headerText = 'お気に入りリスト';
        _isShowFab = false;
      } else if (_selectedIndex == 1) {
        _headerText = '喫煙所探訪';
        _isShowFab = true;
      } else if (_selectedIndex == 2) {
        _headerText = 'お知らせ一覧';
        _isShowFab = false;
      }
    });
  }

  void _moveSpotForm() {
    setState(() {
      Navigator.pushNamed(context, '/spotform');
//      Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) => SpotForm(),
//        ),
//      );
    });
  }

  void _displayMyLocation() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerText: _headerText),
      body: _pageList[_selectedIndex],
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Visibility(
            visible: _isShowFab,
            child: FloatingActionButton(
              heroTag: 'add_location',
              onPressed: _moveSpotForm,
              tooltip: 'スポット投稿',
              child: Icon(Icons.add_location, size: 32),
            ),
          ),
          Visibility(
            visible: _isShowFab,
            child: Container(
              margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: FloatingActionButton(
                heroTag: 'my_location',
                onPressed: _displayMyLocation,
                tooltip: '現在地',
                child: Icon(
                  Icons.my_location,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('お気に入り'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('マップ'),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.search),
//            title: Text('絞り込み'),
//          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            title: Text('お知らせ'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _changePage,
//        type: BottomNavigationBarType.fixed, // タブが4つ以上の場合はこの記述を挿入
        unselectedItemColor: Colors.grey,
//        backgroundColor: Colors.green,
        fixedColor: Colors.green,
        selectedFontSize: 16,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CustomPage extends StatelessWidget {
  final Color pannelColor;
  final String title;

  CustomPage({@required this.pannelColor, @required this.title});

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.title;
    return Container(
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(color: pannelColor, borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: titleTextStyle.fontSize,
                color: titleTextStyle.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
