import 'package:flutter/material.dart';

class PengaturanKotaPage extends StatelessWidget {
  const PengaturanKotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Kota')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Pengaturan kota'),
            const SizedBox(height: 16),
            OutlinedButton(
              // uji route salah: tidak terdaftar
              onPressed: () => Navigator.pushNamed(context, '/rute-salah'),
              child: const Text('Uji Route Tidak Dikenal'),
            ),
          ],
        ),
      ),
    );
  }
}
