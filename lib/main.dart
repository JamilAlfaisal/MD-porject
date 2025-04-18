import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/screens/main_screen.dart';
import 'package:untitled/widgets/app_bar_widget.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.theme = "green"});

  final String? theme;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ColorScheme greenTheme = ColorScheme.fromSeed(
    primary: Color(0xffD0FF84),
    //for appbar and cards or buttons
    seedColor: Color(0xffE7FFBA),
    //for scaffold background and
    secondary: Color(0xFFE7FFBA),
    //for scaffold background and
    onPrimary: Color(0xffEB3131),
    //for edges and corners
    onSecondary: Color(0xffEB3131), //for fonts
  );

  ColorScheme blueTheme = ColorScheme.fromSeed(
    primary: Color(0xff84FFD4),
    //for appbar and cards or buttons
    seedColor: Color(0xffBAFFDC),
    //for scaffold background and
    secondary: Color(0xffBAFFDC),
    //for scaffold background and
    onPrimary: Color(0xff31CCEB),
    //for edges and corners
    onSecondary: Color(0xffEB3131), //for fonts
  );

  ColorScheme purpleTheme = ColorScheme.fromSeed(
    primary: Color(0xffC284FF),
    //for appbar and cards or buttons
    seedColor: Color(0xffE2BAFF),
    //for scaffold background and
    secondary: Color(0xffE2BAFF),
    //for scaffold background and
    onPrimary: Color(0xffA431EB),
    //for edges and corners
    onSecondary: Color(0xffEB3131), //for fonts
  );

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    late ColorScheme color;
    if (widget.theme == "green") {
      color = greenTheme;
    } else if (widget.theme == "blue") {
      color = blueTheme;
    } else {
      color = purpleTheme;
    }
    return MaterialApp(
      theme: ThemeData(
        colorScheme: color,
        iconTheme: IconThemeData(
          color: color.onPrimary,
        ),
        scaffoldBackgroundColor: color.secondary,
        fontFamily: "chau",
        textTheme: TextTheme(
            titleLarge: TextStyle(
              // this is for text on the appbar and for large titles and some buttons
              color: color.onSecondary,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            labelMedium: TextStyle(
              // this is for text on buttons
              color: color.onSecondary,
              fontSize: 15,
            )),
      ),
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(screenWidth, 50),
                child: AppBarWidget(title: "Home",),
            ),
            body: MainScreen(),
          );
        }
      ),
    );
  }
}
