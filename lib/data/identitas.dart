class Identitas {
  final String daftar;
  final String nama;
  final String foto;
  final String ttl;
  final String alamat;
  final String hp;
  final String email;
  final String url;
  final List<String> pendidikan;
  final List<String> penghargaan;

  Identitas({
    required this.daftar,
    required this.nama,
    required this.foto,
    required this.ttl,
    required this.alamat,
    required this.hp,
    required this.email,
    required this.url,
    required this.pendidikan,
    required this.penghargaan,
  });
}
List<Identitas> identity = [
    Identitas(
      daftar: 'Profil Pelaksana 1',
      nama: 'Kevin Joy Nasserino\n',
      foto: 'assets/kevin.png',
      ttl: 'Merauke, 17 Juni 2004',
      alamat: 'Jalan Jemur Andayani No 1',
      hp: '081356272256',
      email: '22082010073@student.upnjatim.ac.id',
      url: 'https://github.com/kevinnasserino',
      pendidikan: [
        '1. SMAN 5 Jayapura',
      ],
      penghargaan: [
        '1. Juara 3 Olimpiade Komputer Matematika dan Statistika Tingkat Porvinsi (SMA)\n'
            '2. Juara 1 LCC 4 Pilar Tingkat Provinsi (SMA)',
      ],
    ),
    Identitas(
      daftar: 'Profil Pelaksana 2',
      nama: 'Anggi Trisna Sari\n',
      foto: 'assets/anggi.png',
      ttl: 'Surabaya, 12 Mei 2004',
      alamat: 'Jalan Plemahan XI Nomor 16',
      hp: '085739234449',
      email: '22082010078@student.upnjatim.ac.id',
      url: 'https://github.com/anggits12',
      pendidikan: [
        '1. SDN Kedungdoro V Surabaya\n'
            '2. SMPN 5 Surabaya\n'
            '3. SMAN 2 Surabaya',
      ],
      penghargaan: [
        '1. Juara 1 Dance Competition pada be the first Champion\n'
            '2. Peserta Semifinalis pada X-Project UI/Ux Competition',
      ],
    ),
  ];
