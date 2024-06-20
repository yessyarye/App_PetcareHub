import 'package:flutter/material.dart';
import 'home_page.dart'; // Ensure this import matches your actual HomePage path
import '../data/user_data.dart' ; 

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;

  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _genderController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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

  void _register() {
    String fullName = _fullNameController.text;
    String username = _usernameController.text;
    String phoneNumber = _phoneNumberController.text;
    String gender = _genderController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (fullName.isEmpty ||
        username.isEmpty ||
        phoneNumber.isEmpty ||
        gender.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showAlertDialog(context, 'Harap isi semua bidang.');
    } else if (password != confirmPassword) {
      _showAlertDialog(context, 'Password dan konfirmasi password tidak cocok.');
    } else {
      bool userExists = users.any((user) => user.username == username);

      if (userExists) {
        _showAlertDialog(context, 'Username sudah ada.');
      } else {
        User newUser = User(
          name: fullName,
          username: username,
          phoneNumber: phoneNumber,
          gender: gender,
          password: password,
          profileImage: '', // Default profile image
        );

        users.add(newUser);
        LoggedInUser.user = newUser;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
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
          padding: EdgeInsets.fromLTRB(25, 85, 26, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 39),
                child: Image.asset(
                  'assets/logo.png',
                  width: 223,
                  height: 165,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(1, 0, 0, 15),
                child: Text(
                  'Selamat datang di PetCare Hub. Silahkan registrasi akun terlebih dahulu...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 1.5,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
              _buildTextField('Nama Lengkap', 'Masukkan nama lengkap', _fullNameController),
              SizedBox(height: 16),
              _buildTextField('Nama Pengguna', 'Masukkan nama pengguna', _usernameController),
              SizedBox(height: 16),
              _buildTextField('Nomor Handphone', 'Masukkan Nomor Handphone', _phoneNumberController),
              SizedBox(height: 16),
              _buildTextField('Jenis Kelamin', 'Masukkan Jenis Kelamin', _genderController),
              SizedBox(height: 16),
              _buildPasswordField('Password', 'Masukkan password', _isObscurePassword, _passwordController),
              SizedBox(height: 16),
              _buildPasswordField('Konfirmasi Password', 'Masukkan ulang password', _isObscureConfirmPassword, _confirmPasswordController),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _register,
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
                  'Daftar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 12),
              ElevatedButton(
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
                    EdgeInsets.symmetric(vertical: 14, horizontal: 80),
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

  Widget _buildTextField(String label, String hintText, TextEditingController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.4,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFFFFFFF),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 9, 15, 9),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, String hintText, bool isObscure, TextEditingController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                height: 1.4,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFFFFFFF),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: TextFormField(
              controller: controller,
              obscureText: isObscure,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      if (hintText == 'Masukkan password') {
                        _isObscurePassword = !_isObscurePassword;
                      } else if (hintText == 'Masukkan ulang password') {
                        _isObscureConfirmPassword = !_isObscureConfirmPassword;
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}