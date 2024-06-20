import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Pet {
  String name;
  String gender;
  String birthdate;
  double weight;
  String species;
  String breed;

  Pet({
    required this.name,
    required this.gender,
    required this.birthdate,
    required this.weight,
    required this.species,
    required this.breed,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PetPage(),
    );
  }
}

class PetPage extends StatefulWidget {
  @override
  _PetPageState createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  List<Pet> _pets = [];

  void _addPet(Pet pet) {
    setState(() {
      _pets.add(pet);
    });

    // Show a SnackBar notification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pet telah ditambahkan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _pets.isEmpty
                ? Center(child: Text('Anda belum memiliki pet.'))
                : ListView.builder(
                    itemCount: _pets.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(_pets[index].name),
                          subtitle: Text(
                            'Gender: ${_pets[index].gender}, Birthdate: ${_pets[index].birthdate}, Weight: ${_pets[index].weight}, Species: ${_pets[index].species}, Breed: ${_pets[index].breed}',
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPetPage(addPet: _addPet),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('Tambah Pet'),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class AddPetPage extends StatefulWidget {
  final Function(Pet) addPet;

  AddPetPage({required this.addPet});

  @override
  _AddPetPageState createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _gender = '';
  String _birthdate = '';
  double _weight = 0;
  String _species = '';
  String _breed = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pet name';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Gender'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pet gender';
                    }
                    return null;
                  },
                  onSaved: (value) => _gender = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Birthdate'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pet birthdate';
                    }
                    return null;
                  },
                  onSaved: (value) => _birthdate = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Weight'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pet weight';
                    }
                    return null;
                  },
                  onSaved: (value) => _weight = double.parse(value!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Species'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pet species';
                    }
                    return null;
                  },
                  onSaved: (value) => _species = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Breed'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pet breed';
                    }
                    return null;
                  },
                  onSaved: (value) => _breed = value!,
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        widget.addPet(Pet(
                          name: _name,
                          gender: _gender,
                          birthdate: _birthdate,
                          weight: _weight,
                          species: _species,
                          breed: _breed,
                        ));
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('Add Pet'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
