import 'package:flutter/material.dart';
import 'package:smokeapp/spot_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // 表示中の Widget を取り出すための index としての int 型の mutable な stored property
  int _selectedIndex = 0;

  // 表示する ページ の一覧
  static List<Widget> _pageList = [
    Center(child: Text('地図だよー')),
//    CustomPage(pannelColor: Colors.cyan, title: 'マップ'),
    CustomPage(pannelColor: Colors.green, title: 'お気に入り'),
    CustomPage(pannelColor: Colors.pink, title: 'お知らせ')
  ];

  // タップ時の処理
  void _changePage(int index) {
    setState(() {
      _selectedIndex = index;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(42.0), // here the desired height
        child: AppBar(
          centerTitle: true,
          title: Text('喫煙所探訪'),
        ),
      ),
      body: _pageList[_selectedIndex],
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'add_location',
            onPressed: _moveSpotForm,
            tooltip: 'スポット投稿',
            child: Icon(Icons.add_location, size: 32),
          ),
          Container(
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('マップ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('お気に入り'),
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
