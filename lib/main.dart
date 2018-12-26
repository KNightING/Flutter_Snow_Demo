import 'package:flutter/material.dart';
import 'drop_snow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Snow Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor:Colors.black,
      ),
      home: MyHomePage(title: 'SNOW DEMO HOME PAGE'),
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            // Positioned.fill(
            //   child: Container(
            //     color: Color(0x22000000),
            //   ),
            // ),

            FractionallySizedBox(
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Colors.indigo[800],
                      Colors.indigo[700],
                      Colors.indigo[600],
                      Colors.indigo[400],
                    ],
                  ),
                ),

                // color: Color(0x22000000),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1.apply(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            DropSnow(
              count: 200,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
