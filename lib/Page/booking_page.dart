import 'package:flutter/material.dart';
import 'history_page.dart';
import '../data/booking.dart';

class GroomingBookingPage extends StatefulWidget {
  final List<Booking> bookings;

  GroomingBookingPage({required this.bookings});

  @override
  _GroomingFormState createState() => _GroomingFormState();
}

class _GroomingFormState extends State<GroomingBookingPage> {
  final _formKey = GlobalKey<FormState>();
  String ownerName = '';
  String petName = '';
  String petType = 'Anjing';
  String serviceType = 'Pet Grooming';
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  Widget _buildServiceTypeCard(String title, IconData icon, String selectedServiceType) {
    bool isSelected = serviceType == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          serviceType = title;
        });
      },
      child: Card(
        color: isSelected ? Colors.blue : Colors.white,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: isSelected ? Colors.white : Colors.blue),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveBooking() {
    final newBooking = Booking(
      ownerName: ownerName,
      petName: petName,
      petType: petType,
      serviceType: serviceType,
      selectedDate: selectedDate,
    );

    setState(() {
      widget.bookings.add(newBooking);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Grooming booked successfully for $serviceType'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Layanan Grooming'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: _buildInputDecoration('Nama Pemilik'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan nama pemilik';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      ownerName = value!;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: _buildInputDecoration('Nama Hewan'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukkan nama hewan';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      petName = value!;
                    },
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: petType,
                    decoration: _buildInputDecoration('Jenis Hewan'),
                    items: ['Anjing', 'Kucing', 'Burung'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        petType = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Pilih Tanggal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                    title: Text("${selectedDate.toLocal()}".split(' ')[0]),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildServiceTypeCard('Pet Grooming', Icons.cut, serviceType),
                      _buildServiceTypeCard('Pet Hotel', Icons.hotel, serviceType),
                      _buildServiceTypeCard('Pet Clinic', Icons.local_hospital, serviceType),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _saveBooking();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent, // Button color
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Button size
                      textStyle: TextStyle(fontSize: 18), // Text size
                    ),
                    child: Text('Pesan Sekarang'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryPage(bookings: widget.bookings),
                        ),
                      );
                    },
                    child: Text('Lihat Riwayat Pesanan'),
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
