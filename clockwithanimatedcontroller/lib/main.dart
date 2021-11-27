import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock with AnimatedController',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Clock with AnimatedController'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final duration = const Duration(seconds: 1);
  late AnimationController _ctrl;

  bool _flag = true;

  static const double _widthRatio = 0.7;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(duration: duration, vsync: this)
      ..addListener(() => setState(() {}))
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _ctrl.reverse();
          _flag = false;
        } else if (status == AnimationStatus.dismissed) {
          _ctrl.forward();
          _flag = true;
        }
      });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * _widthRatio;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_flag)
              SizedBox(
                width: width,
                child: Image.asset(
                  "images/20211127_flag_red.png",
                  fit: BoxFit.cover,
                ),
              )
            else
              SizedBox(
                width: width,
                child: Image.asset(
                  "images/20211127_flag_white.png",
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
