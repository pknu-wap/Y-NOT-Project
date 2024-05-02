import 'package:flutter/material.dart';
import 'package:flutter_01/LoginPage.dart';
import 'package:get/get.dart';
import 'Book_SearchList.dart'; // 수정: 파일 이름을 BookList.dart로 변경

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFE4D02), // 상단바 배경 색상
        ),
      ),
      initialRoute: '/',
      routes: {
        '/success': (context) => BookList(), // 수정: 정의된 위젯 이름을 사용
      },
      home: LoginPage(),
    );
  }
}