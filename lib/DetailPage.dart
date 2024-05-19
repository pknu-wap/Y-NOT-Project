import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅창'),
      ),
      body: const Center(
        child: Text('채팅창'),
      ),
    );
  }
}

class AlarmPage extends StatelessWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알람'),
      ),
      body: const Center(
        child: Text('알람 페이지'),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final List<Map<String, String>> _dummyData = [
    {
      'imageUrl': 'https://via.placeholder.com/350',
      'title': '책 제목 1',
      'author': '작가 이름 1',
      'publisher': '출판사 이름 1',
    },
    {
      'imageUrl': 'https://via.placeholder.com/350',
      'title': '책 제목 2',
      'author': '작가 이름 2',
      'publisher': '출판사 이름 2',
    },
    // 추가적인 더미 데이터들을 필요에 따라 여기에 추가할 수 있습니다.
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x0fffffff), // 상단 바 배경색을 흰색으로 설정
        title: const Text(
          '상세 정보',
          style: TextStyle(color: Colors.black), // 텍스트를 흰색으로 설정
        ),
        centerTitle: true, // 텍스트를 중앙에 배치
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // 뒤로가기 아이콘
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로가기 버튼 클릭 시 이전 페이지로 돌아가기
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // 오른쪽 여백 추가
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlarmPage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // 아이콘 내부 색상을 흰색으로 설정
                ),
                child: const Icon(
                  Icons.notifications, // 알림 아이콘
                  color: Color(0xFFFE4D02), // 아이콘 테두리 색상 설정
                  size: 24, // 알림 아이콘 크기 설정
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const Divider(
            height: 1, // 선의 높이 설정
            color: Colors.grey, // 선의 색상 설정
          ),
          SizedBox(
            height: 250.0, // 사진 크기를 더 크게 조정
            child: PageView.builder(
              itemCount: _dummyData.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    _dummyData[index]['imageUrl']!,
                    fit: BoxFit.cover, // 이미지를 화면에 꽉 채우기 위해 설정
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16), // 페이지 인디케이터와 사진 사이에 간격 추가
          _buildPageIndicator(), // 페이지 인디케이터 추가
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _dummyData[_currentPage]['title']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '저자: ${_dummyData[_currentPage]['author']}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '출판사: ${_dummyData[_currentPage]['publisher']}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16.0), // 버튼 주위의 여백 설정
          color: Colors.white, // 배경 색상 설정
          child: ElevatedButton(
            onPressed: () {
              // 채팅하기 버튼을 누르면 채팅창으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFE4D02), // 버튼의 배경 색상을 FFFE4D02로 설정
              shape: RoundedRectangleBorder( // 버튼의 모서리를 조절하는 설정
                borderRadius: BorderRadius.circular(8.0), // 모서리를 8.0으로 조절
              ),
              minimumSize: const Size(double.infinity, 50), // 버튼의 최소 크기 설정
            ),
            child: const SizedBox(
              width: double.infinity, // 버튼의 가로 크기를 화면 전체로 설정
              child: Text(
                '채팅 하기',
                textAlign: TextAlign.center, // 텍스트를 가운데로 정렬
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ),
    );
  }

  Widget _buildPageIndicator() { //사진 순서에 따른 점 채우기 인디케이터
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_dummyData.length, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? Color(0xFFFE4D02) // 선택된 페이지는 주황색으로 설정
                : Colors.grey, // 선택되지 않은 페이지는 회색으로 설정
          ),
        );
      }),
    );
  }
}
