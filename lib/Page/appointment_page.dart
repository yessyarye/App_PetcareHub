import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dart:async';


class AppointmentPage extends StatefulWidget {
  final String vetName;
  final String vetAddress;
  final String vetHours;
  final String imagePath;

  const AppointmentPage({
    Key? key,
    required this.vetName,
    required this.vetAddress,
    required this.vetHours,
    required this.imagePath,
  }) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final TextEditingController _namaPenggunaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _waktuController = TextEditingController();
  final TextEditingController _petController = TextEditingController();

  bool _isAllFieldsFilled = false;

  @override
  void initState() {
    super.initState();
    _namaPenggunaController.addListener(_checkFields);
    _tanggalController.addListener(_checkFields);
    _waktuController.addListener(_checkFields);
    _petController.addListener(_checkFields);
  }

  @override
  void dispose() {
    _namaPenggunaController.dispose();
    _tanggalController.dispose();
    _waktuController.dispose();
    _petController.dispose();
    super.dispose();
  }

  void _checkFields() {
    setState(() {
      _isAllFieldsFilled = _namaPenggunaController.text.isNotEmpty &&
          _tanggalController.text.isNotEmpty &&
          _waktuController.text.isNotEmpty &&
          _petController.text.isNotEmpty;
    });
  }

  void _buatJanji() {
    if (_isAllFieldsFilled) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookingSplashScreen()),
      ).then((_) {
        // Handle the pop if needed after the BookingSplashScreen is dismissed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Janji - ${widget.vetName}'),
        backgroundColor: Color(0xFF42A5F5),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
            children: [
              Image.asset(
                widget.imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              Text(
                widget.vetName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Praktek Dokter Hewan Pribadi',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey, size: 18),
                  SizedBox(width: 4.0),
                  Text(widget.vetAddress),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.grey, size: 18),
                  SizedBox(width: 4.0),
                  Text(widget.vetHours),
                ],
              ),
              SizedBox(height: 16.0),
              _buildInput('Nama Pemilik', 'Masukkan Nama Pemilik', _namaPenggunaController),
              SizedBox(height: 16.0),
              _buildInput('Tanggal Kunjungan', 'Masukkan Tanggal Kunjungan, Ex : 11-2-25', _tanggalController),
              SizedBox(height: 16.0),
              _buildInput('Waktu Kunjungan', 'Masukkan Waktu Kunjungan, Ex : 13.00', _waktuController),
              SizedBox(height: 16.0),
              _buildInput('Nama Pet', 'Masukkan Nama Pet', _petController),
              SizedBox(height: 16.0),
              Text(
                'Informasi Tambahan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Masukkan informasi tambahan disini',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: _isAllFieldsFilled ? _buatJanji : null,
                  child: Text('Buat Janji'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF42A5F5),
                    padding: EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Harap isi kolom ini';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class BookingSplashScreen extends StatefulWidget {
  @override
  _BookingSplashScreenState createState() => _BookingSplashScreenState();
}
class _BookingSplashScreenState extends State<BookingSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000), // Duration for the scale animation
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward(); // Start the animation

    // Schedule a callback to navigate to the homepage after 0.5 seconds
    Timer(Duration(milliseconds: 1000), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Janji Berhasil Dibuat!",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}