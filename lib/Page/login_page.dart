import 'package:flutter/material.dart';
import 'home_page.dart';
import '../data/user_data.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showAlertDialog(context, 'Harap isi semua bidang.');
    } else {
      try {
        User user = users.firstWhere(
            (user) => user.username == username && user.password == password);
        
        LoggedInUser.user = user;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        _showAlertDialog(context, 'Username atau password salah.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          padding: EdgeInsets.fromLTRB(25, 85, 25, 204),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 39),
                child: Image.asset(
                  'assets/logo.png',
                  width: 223,
                  height: 165,
                  fit: BoxFit.contain,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Selamat datang kembali\n di PetCare Hub.\n Silahkan login terlebih dahulu...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 1.5,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    'Nama Pengguna',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _usernameController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  labelText: 'Nama Pengguna',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                textAlign: TextAlign.left,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF475EDF)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 14, horizontal: 80),
                  ),
                ),
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFB703)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 14, horizontal: 70),
                  ),
                ),
                child: Text(
                  'Kembali',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
