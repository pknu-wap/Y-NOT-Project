import 'package:flutter/material.dart';
import 'package:flutter_01/Save_space.dart';
import 'package:flutter_01/Alarm_space.dart';
import 'Searchresult.dart';
import 'Book_SearchList.dart';

class Main_Page extends StatefulWidget {
  const Main_Page({super.key});

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(useMaterial3: true);
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(children: [
                const SizedBox(width: 300),
                SaveCon(),
                const SizedBox(width: 1),
                AlarmCon(),
                const SizedBox(height: 20),
              ]),
              SearchB(),
              const SizedBox(height: 10),
              Row(children: [
                Recent_text(),
              ]),
              Recent_Activity(),
              Row(children: [
                Find_text(),
              ]),
              Find_Activity(),
              Row(children: [
                Realtime_text(),
              ]),
              Realtime_Activity(),
              UnderB(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget Recent_text() {
    return Text(
      'User 활동 내역',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 15, // 폰트 크기
        fontWeight: FontWeight.bold, // 폰트 두께
        color: Colors.black, // 폰트 색상
      ),
    );
  }

  Widget Find_text() {
    return Text(
      '찾고 계시는 책이 있나요?',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 15, // 폰트 크기
        fontWeight: FontWeight.bold, // 폰트 두께
        color: Colors.black, // 폰트 색상
      ),
    );
  }

  Widget Realtime_text() {
    return Text(
      '실시간 최근 올라온 책들',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 15, // 폰트 크기
        fontWeight: FontWeight.bold, // 폰트 두께
        color: Colors.black, // 폰트 색상
      ),
    );
  }

  Widget Find_Activity() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: RangeMaintainingScrollPhysics(),
      child: Row(
        children: [
          Container(
              child:
              Image.asset('image/picture_1.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_2.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_3.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_4.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_5.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }

  Widget Recent_Activity() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
              child:
              Image.asset('image/picture_1.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_2.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_3.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_4.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_5.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }

  Widget Realtime_Activity() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
              child:
              Image.asset('image/picture_1.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_2.png', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_3.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_4.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
          Container(
              child:
              Image.asset('image/picture_5.jpeg', height: 150, width: 150),
              padding: EdgeInsets.all(10)),
        ],
      ),
    );
  }

  Widget SaveCon() {
    return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SaveSpace()),
          );
        },
        color: Colors.orangeAccent,
        icon: Icon(Icons.bookmark_outline_outlined));
  }

  Widget AlarmCon() {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlarmSpace()),
        );
      },
      icon: Icon(Icons.notifications_none),
      iconSize: 30,
      color: Colors.orangeAccent,
    );
  }

  List<searchresult> searchResults = [];

  void searchList(String query) {
    final results = searchResults
        .where((product) => product.subject.contains(query))
        .toList();
    setState(() {
      searchResults = results;
    });
  }

  String? inputText;

  Widget SearchB() {
    return SearchBar(
      onChanged: (value) {
        setState(() {
          inputText = value;
        });
      },
      leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            debugPrint(inputText);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BookList(
                          Searchresult: searchresult(
                              subject: inputText ?? '',
                              auther: '',
                              publishing: ''))),
            );
          }),
      hintText: "검색어를 입력하세요",
      backgroundColor: MaterialStatePropertyAll(Colors.white70),
    );
  }

  Widget UnderB(){
  return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int wants){
          switch (wants){
            case 0:
          Navigator.push(context,MaterialPageRoute(builder:(context) => Main_Page()));
              break;
            case 1:
              Navigator.push(context,MaterialPageRoute(builder:(context) => BookList(
                  Searchresult: searchresult(
                      subject: inputText ?? '',
                      auther: '',
                      publishing: ''))));
              break;
            /*case 2:

              break;*/
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(
            Icons.home_outlined,
          ),label: '홈'),
          BottomNavigationBarItem(icon: Icon(
            Icons.add_outlined,
          ),label: '판매'),
      ],
      ),
    );
  }
}
