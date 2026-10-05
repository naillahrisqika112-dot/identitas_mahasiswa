import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ======================================================
// WARNA APLIKASI
// ======================================================

const Color creamBackground = Color(0xFFFFF8E7);
const Color creamCard = Color(0xFFFFFDF5);
const Color creamDark = Color(0xFFF3E5C8);
const Color brown = Color(0xFF8B6F47);
const Color darkBrown = Color(0xFF5D4630);

// ======================================================
// MODEL MAHASISWA
// ======================================================

class Mahasiswa {
  String nama;
  double tugas;
  double uts;
  double uas;

  Mahasiswa({
    required this.nama,
    required this.tugas,
    required this.uts,
    required this.uas,
  });

  // Nilai akhir:
  // 30% Tugas + 30% UTS + 40% UAS
  double get nilaiAkhir {
    return (tugas * 0.30) +
        (uts * 0.30) +
        (uas * 0.40);
  }

  // Grade
  String get grade {
    if (nilaiAkhir >= 85) {
      return 'A';
    } else if (nilaiAkhir >= 75) {
      return 'B';
    } else if (nilaiAkhir >= 65) {
      return 'C';
    } else if (nilaiAkhir >= 50) {
      return 'D';
    } else {
      return 'E';
    }
  }

  // Status
  String get status {
    if (nilaiAkhir >= 60) {
      return 'Lulus';
    } else {
      return 'Tidak Lulus';
    }
  }
}

// ======================================================
// MAIN APP
// ======================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Kalkulator Nilai Mahasiswa',

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor:
            creamBackground,

        colorScheme: ColorScheme.fromSeed(
          seedColor: brown,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: brown,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        inputDecorationTheme:
            InputDecorationTheme(
          filled: true,
          fillColor: creamCard,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(
              Radius.circular(15),
            ),
          ),

          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: Color(0xFFD6C3A5),
            ),
          ),

          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: brown,
              width: 2,
            ),
          ),
        ),
      ),

      home: const NilaiPage(),
    );
  }
}

// ======================================================
// HALAMAN UTAMA
// ======================================================

class NilaiPage extends StatefulWidget {
  const NilaiPage({super.key});

  @override
  State<NilaiPage> createState() =>
      _NilaiPageState();
}

class _NilaiPageState
    extends State<NilaiPage> {

  // ====================================================
  // CONTROLLER
  // ====================================================

  final TextEditingController
      namaController =
      TextEditingController();

  final TextEditingController
      tugasController =
      TextEditingController();

  final TextEditingController
      utsController =
      TextEditingController();

  final TextEditingController
      uasController =
      TextEditingController();

  // ====================================================
  // 10 DATA MAHASISWA
  // ====================================================

  final List<Mahasiswa> daftarMahasiswa = [
    Mahasiswa(
      nama: 'Naillah Risqika Intan Saputri',
      tugas: 80,
      uts: 75,
      uas: 90,
    ),
    Mahasiswa(
      nama: 'Gandis Asmara',
      tugas: 70,
      uts: 80,
      uas: 75,
    ),
    Mahasiswa(
      nama: 'Haya Agniya Jaida Malik',
      tugas: 90,
      uts: 85,
      uas: 95,
    ),
    Mahasiswa(
      nama: 'Putri Auliah Rahmatila',
      tugas: 60,
      uts: 65,
      uas: 70,
    ),
    Mahasiswa(
      nama: 'Zenissa Pratiwi',
      tugas: 50,
      uts: 60,
      uas: 55,
    ),
    Mahasiswa(
      nama: 'Dhimar Gevira Agista',
      tugas: 85,
      uts: 90,
      uas: 88,
    ),
    Mahasiswa(
      nama: 'Sebriana Sihotang',
      tugas: 75,
      uts: 70,
      uas: 80,
    ),
    Mahasiswa(
      nama: 'Muhammad Ripki',
      tugas: 45,
      uts: 50,
      uas: 40,
    ),
    Mahasiswa(
      nama: 'Bontor Silalahi',
      tugas: 95,
      uts: 92,
      uas: 90,
    ),
    Mahasiswa(
      nama: 'Rosmery Revalita Simatupang',
      tugas: 65,
      uts: 60,
      uas: 70,
    ),
  ];

  // ====================================================
  // TAMBAH MAHASISWA
  // ====================================================

  void tambahMahasiswa() {
    String nama =
        namaController.text.trim();

    double? tugas =
        double.tryParse(
      tugasController.text,
    );

    double? uts =
        double.tryParse(
      utsController.text,
    );

    double? uas =
        double.tryParse(
      uasController.text,
    );

    // Cek input
    if (nama.isEmpty ||
        tugas == null ||
        uts == null ||
        uas == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Semua data harus diisi!',
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    // Cek nilai
    if (tugas < 0 ||
        tugas > 100 ||
        uts < 0 ||
        uts > 100 ||
        uas < 0 ||
        uas > 100) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Nilai harus antara 0 sampai 100!',
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    setState(() {
      daftarMahasiswa.add(
        Mahasiswa(
          nama: nama,
          tugas: tugas,
          uts: uts,
          uas: uas,
        ),
      );
    });

    namaController.clear();
    tugasController.clear();
    utsController.clear();
    uasController.clear();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          'Data berhasil ditambahkan!',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  // ====================================================
  // HAPUS MAHASISWA
  // ====================================================

  void hapusMahasiswa(int index) {
    setState(() {
      daftarMahasiswa.removeAt(index);
    });
  }

  // ====================================================
  // HAPUS SEMUA
  // ====================================================

  void hapusSemua() {
    setState(() {
      daftarMahasiswa.clear();
    });
  }

  // ====================================================
  // INPUT NILAI
  // ====================================================

  Widget inputNilai({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,

      keyboardType:
          const TextInputType.numberWithOptions(
        decimal: true,
      ),

      decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(
          icon,
          color: brown,
        ),
      ),
    );
  }

  // ====================================================
  // BUILD
  // ====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ==================================================
      // APP BAR
      // ==================================================

      appBar: AppBar(
        title: const Text(
          'Kalkulator Nilai Mahasiswa',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ==================================================
      // BODY
      // ==================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [

            // ============================================
            // HEADER
            // ============================================

            Container(
              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: creamDark,

                borderRadius:
                    BorderRadius.circular(20),

                border: Border.all(
                  color: const Color(
                    0xFFD6C3A5,
                  ),
                ),
              ),

              child: Column(
                children: [

                  const Icon(
                    Icons.school,
                    size: 50,
                    color: darkBrown,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Kalkulator Nilai Mahasiswa',

                    textAlign:
                        TextAlign.center,

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Aplikasi Perhitungan Nilai',
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          Colors.brown.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ============================================
            // FORM
            // ============================================

            Card(
              color: creamCard,

              elevation: 4,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Padding(
                padding:
                    const EdgeInsets.all(20),

                child: Column(
                  children: [

                    const Align(
                      alignment:
                          Alignment.centerLeft,

                      child: Text(
                        'Input Data Mahasiswa',

                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                          color: darkBrown,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // NAMA
                    TextField(
                      controller:
                          namaController,

                      decoration:
                          const InputDecoration(
                        labelText:
                            'Nama Mahasiswa',

                        prefixIcon:
                            Icon(
                          Icons.person,
                          color: brown,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // TUGAS
                    inputNilai(
                      label:
                          'Nilai Tugas',
                      controller:
                          tugasController,
                      icon:
                          Icons.assignment,
                    ),

                    const SizedBox(height: 15),

                    // UTS
                    inputNilai(
                      label:
                          'Nilai UTS',
                      controller:
                          utsController,
                      icon:
                          Icons.edit_note,
                    ),

                    const SizedBox(height: 15),

                    // UAS
                    inputNilai(
                      label:
                          'Nilai UAS',
                      controller:
                          uasController,
                      icon:
                          Icons.school,
                    ),

                    const SizedBox(height: 20),

                    // BUTTON
                    SizedBox(
                      width:
                          double.infinity,

                      child:
                          ElevatedButton.icon(
                        onPressed:
                            tambahMahasiswa,

                        icon:
                            const Icon(
                          Icons.add,
                        ),

                        label:
                            const Text(
                          'Tambah Mahasiswa',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              brown,

                          foregroundColor:
                              Colors.white,

                          padding:
                              const EdgeInsets
                                  .symmetric(
                            vertical: 15,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ============================================
            // JUMLAH MAHASISWA
            // ============================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,

              children: [

                const Text(
                  'Daftar Mahasiswa',

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                    color: darkBrown,
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),

                  decoration:
                      BoxDecoration(
                    color: brown,

                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),

                  child: Text(
                    '${daftarMahasiswa.length} Mahasiswa',

                    style:
                        const TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // ============================================
            // DATA MAHASISWA
            // ============================================

            ...daftarMahasiswa
                .asMap()
                .entries
                .map((entry) {

              int index = entry.key;

              Mahasiswa mahasiswa =
                  entry.value;

              bool lulus =
                  mahasiswa.status ==
                      'Lulus';

              return Card(
                color: creamCard,

                elevation: 3,

                margin:
                    const EdgeInsets.only(
                  bottom: 15,
                ),

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),

                child: Padding(
                  padding:
                      const EdgeInsets.all(18),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // NAMA
                      Row(
                        children: [

                          Container(
                            width: 40,
                            height: 40,

                            decoration:
                                BoxDecoration(
                              color: creamDark,

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          12),
                            ),

                            child:
                                const Icon(
                              Icons.person,
                              color:
                                  darkBrown,
                            ),
                          ),

                          const SizedBox(
                              width: 12),

                          Expanded(
                            child: Text(
                              '${index + 1}. ${mahasiswa.nama}',

                              style:
                                  const TextStyle(
                                fontSize: 19,
                                fontWeight:
                                    FontWeight.bold,
                                color:
                                    darkBrown,
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              hapusMahasiswa(
                                  index);
                            },

                            icon:
                                const Icon(
                              Icons.delete,
                              color:
                                  Colors.red,
                            ),
                          ),
                        ],
                      ),

                      const Divider(
                        color:
                            Color(0xFFD6C3A5),
                      ),

                      const SizedBox(height: 5),

                      // NILAI TUGAS
                      Text(
                        'Nilai Tugas : '
                        '${mahasiswa.tugas.toStringAsFixed(2)}',

                        style:
                            const TextStyle(
                          fontSize: 15,
                        ),
                      ),

                      // NILAI UTS
                      Text(
                        'Nilai UTS   : '
                        '${mahasiswa.uts.toStringAsFixed(2)}',

                        style:
                            const TextStyle(
                          fontSize: 15,
                        ),
                      ),

                      // NILAI UAS
                      Text(
                        'Nilai UAS   : '
                        '${mahasiswa.uas.toStringAsFixed(2)}',

                        style:
                            const TextStyle(
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ==================================
                      // HASIL NILAI
                      // ==================================

                      Container(
                        width:
                            double.infinity,

                        padding:
                            const EdgeInsets
                                .all(16),

                        decoration:
                            BoxDecoration(
                          color: creamDark,

                          borderRadius:
                              BorderRadius
                                  .circular(
                                      15),

                          border:
                              Border.all(
                            color:
                                const Color(
                              0xFFD6C3A5,
                            ),
                          ),
                        ),

                        child: Column(
                          children: [

                            const Text(
                              'NILAI AKHIR',

                              style:
                                  TextStyle(
                                fontSize: 13,
                                color:
                                    darkBrown,
                              ),
                            ),

                            const SizedBox(
                                height: 5),

                            Text(
                              mahasiswa
                                  .nilaiAkhir
                                  .toStringAsFixed(
                                      2),

                              style:
                                  const TextStyle(
                                fontSize: 30,
                                fontWeight:
                                    FontWeight.bold,
                                color:
                                    darkBrown,
                              ),
                            ),

                            const SizedBox(
                                height: 5),

                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 15,
                                vertical: 7,
                              ),

                              decoration:
                                  BoxDecoration(
                                color: brown,

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            20),
                              ),

                              child: Text(
                                'Grade ${mahasiswa.grade}',

                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(
                                height: 8),

                            Text(
                              mahasiswa.status,

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,

                                color: lulus
                                    ? Colors
                                        .green
                                    : Colors
                                        .red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // ============================================
            // HAPUS SEMUA
            // ============================================

            if (daftarMahasiswa.isNotEmpty)
              OutlinedButton.icon(
                onPressed:
                    hapusSemua,

                icon:
                    const Icon(
                  Icons.delete_sweep,
                  color: Colors.red,
                ),

                label:
                    const Text(
                  'Hapus Semua Data',

                  style: TextStyle(
                    color: Colors.red,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                style:
                    OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),

            const SizedBox(height: 25),

            // ============================================
            // KETENTUAN
            // ============================================

            Card(
              color: creamDark,

              elevation: 2,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                        18),
              ),

              child: Padding(
                padding:
                    const EdgeInsets.all(20),

                child: Column(
                  children: [

                    const Icon(
                      Icons.info_outline,
                      size: 35,
                      color: darkBrown,
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Ketentuan Penilaian',

                      style: TextStyle(
                        fontSize: 19,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            darkBrown,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Nilai Akhir',

                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        color:
                            darkBrown,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      '30% Tugas + '
                      '30% UTS + '
                      '40% UAS',

                      textAlign:
                          TextAlign.center,
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'A  ≥ 85\n'
                      'B  ≥ 75\n'
                      'C  ≥ 65\n'
                      'D  ≥ 50\n'
                      'E  < 50',

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Nilai ≥ 60 = Lulus\n'
                      'Nilai < 60 = Tidak Lulus',

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ====================================================
  // DISPOSE
  // ====================================================

  @override
  void dispose() {
    namaController.dispose();
    tugasController.dispose();
    utsController.dispose();
    uasController.dispose();

    super.dispose();
  }
}
