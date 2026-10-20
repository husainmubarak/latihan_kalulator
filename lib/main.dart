import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Logika UTS',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  // Controller untuk membaca teks input
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();

  // Variabel penampung hasil state
  double _hasil = 0.0;
  String _keterangan = '';

  void _hitung(String operasi) {
    // Parsing angka dari controller
    double a = double.tryParse(_angka1Controller.text) ?? 0.0;
    double b = double.tryParse(_angka2Controller.text) ?? 0.0;

    // Memperbarui State UI
    setState(() {
      if (operasi == '+') {
        _hasil = a + b;
      } else if (operasi == '-') {
        _hasil = a - b;
      } else if (operasi == '*') {
        _hasil = a * b;
      } else if (operasi == '/') {
        _hasil = b != 0 ? a / b : 0.0;
      }

      // Contoh Logika Kondisional (misal: menentukan Lulus/Tidak atau Ganjil/Genap)
      if (_hasil >= 70) {
        _keterangan = 'Kategori: LULUS (Nilai ≥ 70)';
      } else {
        _keterangan = 'Kategori: TIDAK LULUS (Nilai < 70)';
      }
    });
  }

  void _reset() {
    setState(() {
      _angka1Controller.clear();
      _angka2Controller.clear();
      _hasil = 0.0;
      _keterangan = '';
    });
  }

  @override
  void dispose() {
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator & Logika Dart'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Angka Pertama
            TextField(
              controller: _angka1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masukkan Angka Pertama / Nilai Tugas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // Input Angka Kedua
            TextField(
              controller: _angka2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Masukkan Angka Kedua / Nilai UTS',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Tombol Operasi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => _hitung('+'), child: const Text('+')),
                ElevatedButton(onPressed: () => _hitung('-'), child: const Text('-')),
                ElevatedButton(onPressed: () => _hitung('*'), child: const Text('×')),
                ElevatedButton(onPressed: () => _hitung('/'), child: const Text('÷')),
              ],
            ),

            const SizedBox(height: 12),

            OutlinedButton(
              onPressed: _reset,
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Reset Form'),
            ),

            const SizedBox(height: 24),

            // Container Menampilkan Hasil
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo),
              ),
              child: Column(
                children: [
                  const Text('Hasil Perhitungan:', style: TextStyle(fontSize: 16)),
                  Text(
                    _hasil.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _keterangan,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _hasil >= 70 ? Colors.green : Colors.red,
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