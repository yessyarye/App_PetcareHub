import 'package:flutter/material.dart';
import 'package:uas_pemmob/Page/history_page.dart';
import 'booking_page.dart';
import 'pet_information.dart';
import 'profil_page.dart';
import 'search_vet_page.dart';
import '../data/user_data.dart';
import '../data/booking.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  List<Booking> bookings = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentPage == 0
          ? AppBar(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: LoggedInUser.user != null && LoggedInUser.user!.profileImage.isNotEmpty
                    ? ClipOval(
                        child: Image.asset(
                          LoggedInUser.user!.profileImage,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                      )
                    : Icon(Icons.person, color: Colors.grey[800]),
              ),
              title: Text('Halo, ${LoggedInUser.user?.name ?? 'User'}!'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                ),
              ],
            )
          : null,
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentPage) {
      case 0:
        return BerandaPage(bookings: bookings);
      case 1:
        return HistoryPage(bookings: bookings);
      case 2:
        return ProfilePage();
      default:
        return SizedBox.shrink();
    }
  }
}

class BerandaPage extends StatelessWidget {
  final List<Booking> bookings;

  BerandaPage({required this.bookings});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      'assets/vetset.jpg',
      'assets/vetset.jpg',
      'assets/beranda.png',
    ];

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            // Image slider
            Container(
              height: 200,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.8),
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imagePaths.map((image) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
                  ),
                );
              }).toList(),
            ),
            // Main section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Main buttons as square cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Cari Klinik
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SearchVetPage()),
                          );
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.local_hospital, color: Colors.white),
                              SizedBox(height: 5),
                              Text(
                                'Cari Klinik',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Edukasi Hewan
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PetInformationPage()),
                          );
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.local_florist, color: Colors.white),
                              SizedBox(height: 5),
                              Text(
                                'Edukasi Hewan',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Layanan Grooming
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GroomingBookingPage(bookings: bookings)),
                          );
                        },
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.history_sharp, color: Colors.white),
                              SizedBox(height: 5),
                              Text(
                                'Layanan Grooming',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('Rekomendasi Klinik', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  // Klinik list
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 150,
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/carovet.jpeg', // Replace with actual image path
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Klinik Hewan',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text('CaroVet'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        
                      },
                    ),
                  ),
                 Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Teks pemisah
                        Text(
                          'Berita Terbaru',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        // Card berita
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.asset(
                                'assets/berita1.jpeg', // Ganti dengan path gambar berita
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '10 Hewan Yang Doyan Tidur',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Manusia umumnya tidur 7 sampai 9 jam per harinya. Namun, hal tersebut tidak berlaku bagi hewan-hewan berikut yang bahkan bisa tidur hingga 22 jam.',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.asset(
                                'assets/berita2.jpeg', // Ganti dengan path gambar berita
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hewan Paling Bahagia Di Dunia',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Dikutip dari World Fund for Nature (WWF), hewan paling bahagia di dunia adalam mamalia berjenis quokka',
                                    ),
                                  ],
                                ),
                                 ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Image.asset(
                                'assets/berita3.jpg', // Ganti dengan path gambar berita
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '5 Hewan Tercepat DI Dunia',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Kecepatan menjadi salah satu kemampua hewan yang paling diandalkan dalam berburu mangsa',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
