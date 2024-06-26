import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>(); // 폼 키를 생성.
  final TextEditingController _usernameController = TextEditingController(); // 사용자 이름을 입력하는 컨트롤러
  final TextEditingController _emailController = TextEditingController(); // 이메일을 입력하는 컨트롤러
  final TextEditingController _passwordController = TextEditingController(); // 비밀번호를 입력하는 컨트롤러
  final TextEditingController _idController = TextEditingController(); // 아이디를 입력하는 컨트롤러 (추가)

  final FirebaseAuth _auth = FirebaseAuth.instance; // FirebaseAuth 인스턴스 생성

  // 학교 이메일 형식을 확인하기 위한 정규표현식
  RegExp emailRegex = RegExp(
    r'^[\w-\.]+@pukyong\.ac\.kr$',
    caseSensitive: false,
    multiLine: false,
  );

  // 이메일 유효성 검사 함수
  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return '이메일을 입력하세요';
    } else if (!emailRegex.hasMatch(value!)) {
      return '올바른 학교 이메일 형식이 아닙니다';
    }
    return null;
  }

  // 회원가입 함수
  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Firestore에 사용자 정보 저장
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
          'username': _usernameController.text,
          'email': _emailController.text,
        });

        // 이메일 인증 메일 전송
        await userCredential.user?.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('인증 이메일이 전송되었습니다. 이메일을 확인해주세요.'),
            backgroundColor: Colors.green,
          ),
        );

        // 회원가입 성공 시 로그인 페이지로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'weak-password':
            errorMessage = '비밀번호가 너무 약합니다.';
            break;
          case 'email-already-in-use':
            errorMessage = '이미 사용 중인 이메일입니다.';
            break;
          default:
            errorMessage = '회원가입에 실패했습니다.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('회원가입에 실패했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('회원 가입', style: TextStyle(color: Colors.white))),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 24.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('사용자 이름', style: TextStyle(fontSize: 16.0)),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: '닉네임',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0), // 입력 창 테두리를 더 둥글게 만듭니다.
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return '닉네임을 입력하세요';
                        } else if (value == 'admin') { // 예시로 "admin"이 중복된 닉네임으로 간주
                          return '이미 사용 중인 닉네임입니다';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('아이디', style: TextStyle(fontSize: 16.0)),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _idController,
                      decoration: InputDecoration(
                        hintText: 'ID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0), // 입력 창 테두리
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return '아이디를 입력하세요';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('이메일', style: TextStyle(fontSize: 16.0)),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'example@pukyong.ac.kr',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0), // 입력 창 테두리
                        ),
                      ),
                      validator: validateEmail,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('비밀번호', style: TextStyle(fontSize: 16.0)),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: '비밀번호',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0), // 입력 창 테두리
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return '비밀번호를 입력하세요';
                        } else if (value!.length < 8) {
                          return '비밀번호는 8자 이상이어야 합니다';
                        } else if (!value.contains(RegExp(r'[0-9]'))) {
                          return '숫자를 포함해야 합니다';
                        } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                          return '특수 문자를 포함해야 합니다';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp,
                child: Text('가입'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFE4D02)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
