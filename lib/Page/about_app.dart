import 'package:flutter/material.dart';
import 'yessy_page.dart';
import 'kevin_page.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Aplikasi'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/logo.png',
                    height: 150.0, width: 150.0),
              ),
              SizedBox(height: 20),
              Text(
                'Petcare Hub v.01',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Selamat datang di Petcare Hub, platform inovatif yang didedikasikan untuk memudahkan Anda dalam merawat dan mengurus hewan peliharaan Anda dengan lebih baik. Petcare Hub hadir dengan visi untuk menyediakan solusi terbaik bagi para pecinta hewan, baik pemilik hewan peliharaan maupun para penyedia layanan hewan.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Petcare Hub adalah tempat di mana Anda dapat menemukan berbagai fitur yang dirancang secara khusus untuk menjaga kesehatan, kebahagiaan, dan kenyamanan hewan peliharaan Anda. Dari jadwal vaksinasi, catatan kesehatan, hingga penjadwalan perawatan rutin, Petcare Hub memberikan kemudahan akses dan pengelolaan informasi yang terintegrasi.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Keamanan dan kenyamanan hewan peliharaan adalah prioritas utama kami. Oleh karena itu, Petcare Hub juga menyediakan akses mudah ke jaringan penyedia layanan hewan yang terpercaya, termasuk dokter hewan, penitipan hewan, penjaga hewan, dan layanan grooming.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Kami percaya bahwa setiap hewan peliharaan adalah bagian berharga dari keluarga Anda, dan dengan Petcare Hub, kami berkomitmen untuk membantu Anda memberikan perawatan terbaik bagi mereka. Bergabunglah dengan komunitas kami dan temukan kemudahan merawat hewan peliharaan Anda dengan Petcare Hub!',
                style: TextStyle(fontSize: 16),
              ),//... (rest of the code remains the same)
              SizedBox(height: 40),
              Text(
                'Developer Petcare Hub',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => YessyPage()),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: AssetImage('assets/yessy.jpg'),
                        ),
                        SizedBox(height: 10),
                        Text('Yessy Arye Yustraini'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KevinPage()),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: AssetImage('assets/kevin.jpg'),
                        ),
                        SizedBox(height: 10),
                        Text('Kevin Joy Nasserino'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



