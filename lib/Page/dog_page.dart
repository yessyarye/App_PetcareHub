import 'package:flutter/material.dart';
import '../services/api_services.dart';

class DogPage extends StatefulWidget {
  @override
  _DogPageState createState() => _DogPageState();
}

class _DogPageState extends State<DogPage> {
  List<Map<String, dynamic>> healthInfo = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchHealthInfo();
  }

  void fetchHealthInfo() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map<String, dynamic>> fetchedHealthInfo = await ApiService.fetchHealthInfoDog('dog');
      setState(() {
        healthInfo = fetchedHealthInfo;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Tentang Anjing'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: healthInfo.length,
              itemBuilder: (context, index) {
                return HealthInfoCard(info: healthInfo[index]);
              },
            ),
    );
  }
}

class HealthInfoCard extends StatelessWidget {
  final Map<String, dynamic> info;

  HealthInfoCard({required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        leading: info['image'] != null
            ? Image.network(info['image'], width: 50, height: 50, fit: BoxFit.cover)
            : null,
        title: Text(info['name'] ?? ''),
        subtitle: Text(info['description'] ?? ''),
      ),
    );
  }
}