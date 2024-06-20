import 'package:flutter/material.dart';
import 'appointment_page.dart';

class SearchVetPage extends StatefulWidget {
  const SearchVetPage({Key? key}) : super(key: key);

  @override
  State<SearchVetPage> createState() => _SearchVetPageState();
}

class _SearchVetPageState extends State<SearchVetPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> allVets = [
    {
      'imagePath': 'assets/surabayaanimalclinic.jpg',
      'vetName': 'Surabaya Animal Clinic',
      'vetAddress': 'Jl. Rungkut Asri Tim. XVII No.19, RW.10',
      'vetHours': 'Setiap Hari (08.00-17.00)',
      'vetPhone': '082132146221'
    },
    {
      'imagePath': 'assets/lingkarsatwa.jpg',
      'vetName': 'Lingkar Satwa Animal Care',
      'vetAddress': 'Jl. Sumatra 31L Gubeng',
      'vetHours': 'Senin - Jumat (09.00-21.00)',
      'vetPhone': '08113273223'
    },
    {
      'imagePath': 'assets/harmonipetcare.jpeg',
      'vetName': 'Harmoni Pet Care ',
      'vetAddress': 'Jl. Gayungsari Timur III ',
      'vetHours': 'Selasa-Minggu (08.00-21.00)',
      'vetPhone': '082231727227'
    },
    {
      'imagePath': 'assets/carovet.jpeg',
      'vetName': 'CaroVet Praktek Dokter Hewan',
      'vetAddress': 'Jl. Raya Wiyung No.9, Wiyung',
      'vetHours': 'Senin - Sabtu (09.00 - 20.00)',
      'vetPhone': '081357255739'
    },
    {
      'imagePath': 'assets/klinikhewan.jpeg',
      'vetName': 'Klinik Hewan (K and P Clinic)',
      'vetAddress': 'Jl. Anggrek No. 10',
      'vetHours': 'Setiap Hari (08.00-17.00)',
      'vetPhone': '0816509222'
    },
  ];
  List<Map<String, String>> filteredVets = [];

  @override
  void initState() {
    super.initState();
    filteredVets = allVets;
    _searchController.addListener(_filterVets);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterVets() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredVets = allVets.where((vet) {
        final vetName = vet['vetName']!.toLowerCase();
        return vetName.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text(
            'Cari Klinik',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: filteredVets.map((vet) {
                  return Column(
                    children: [
                      _buildVetCard(
                        imagePath: vet['imagePath']!,
                        vetName: vet['vetName']!,
                        vetAddress: vet['vetAddress']!,
                        vetHours: vet['vetHours']!,
                        vetPhone: vet['vetPhone']!,
                        context: context,
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildVetCard({
  required String imagePath,
  required String vetName,
  required String vetAddress,
  required String vetHours,
  required String vetPhone,
  required BuildContext context,
}) {
  return SizedBox(
    height: 300,
    width: 400, // Set the desired height for each card
    child: Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentPage(
                vetName: vetName,
                vetAddress: vetAddress,
                vetHours: vetHours,
                imagePath: imagePath,
                // Pass imagePath to AppointmentPage
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vetName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Alamat: $vetAddress',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Jam Buka: $vetHours',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No. Telpon: $vetPhone',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}