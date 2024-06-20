import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/booking.dart';

class HistoryPage extends StatelessWidget {
  final List<Booking> bookings;

  HistoryPage({required this.bookings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          final formattedDate =
              DateFormat('yyyy-MM-dd').format(booking.selectedDate);
          return Card(
            child: ListTile(
              title: Text(booking.serviceType),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama Pemilik  : ${booking.ownerName}'),
                  Text('Nama Hewan    : ${booking.petName}'),
                  Text('Jenis Hewan   : ${booking.petType}'),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Tanggal: $formattedDate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
