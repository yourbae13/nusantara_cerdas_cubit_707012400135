import 'package:flutter/material.dart';

class RiwayatLaporanPage extends StatelessWidget {
  const RiwayatLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final laporan = [
      'Jalan berlubang - Selesai',
      'Lampu jalan mati - Diproses',
      'Sampah menumpuk - Diterima',
      'Saluran tersumbat - Selesai',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Laporan')),
      body: ListView(
        children: [
          for (final l in laporan)
            ListTile(
              leading: const Icon(Icons.report_outlined),
              title: Text(l),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Buat laporan baru'))),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
