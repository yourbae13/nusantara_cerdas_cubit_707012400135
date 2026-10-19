import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  void _info(BuildContext context, String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  Future<void> _ajukanBaru(BuildContext context) async {
    final hasil = await Navigator.pushNamed<String>(
      context,
      AppRoutes.pengajuanBaru,
    ); // named route, bukan push kelas
    if (hasil != null && context.mounted) _info(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.person)),
              title: Text('Bayu Firmansyah'),
              subtitle: Text('NIK: 3577xxxxxxxxxxxx'),
            ),
          ),
          BlocBuilder<FavoritCubit, Set<String>>(
            builder: (context, favorit) {
              if (favorit.isEmpty) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Layanan Favorit (${favorit.length})',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        for (final nama in favorit)
                          InputChip(
                            avatar: const Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.amber,
                            ),
                            label: Text(nama),
                            onDeleted: () =>
                                context.read<FavoritCubit>().batalTandai(nama),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<PengajuanCubit, PengajuanState>(
              builder: (context, state) {
                final daftar = state.daftar;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Riwayat Pengajuan (${state.totalPengajuan})',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    Expanded(
                      child: daftar.isEmpty
                          ? const Center(
                              child: Text(
                                'Belum ada pengajuan.\nTekan tombol + untuk membuat pengajuan baru.',
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                              itemCount: daftar.length,
                              itemBuilder: (context, i) {
                                final p = daftar[i];
                                return GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.rincianPengajuan,
                                    arguments: p.id,
                                  ),
                                  onLongPress: () {
                                    if (p.selesai) return;
                                    context
                                        .read<PengajuanCubit>()
                                        .tandaiSelesai(p.id);
                                    _info(
                                      context,
                                      'Pengajuan ${p.layanan} ditandai selesai ditindaklanjuti',
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                      leading: Icon(
                                        p.selesai
                                            ? Icons.check_circle
                                            : Icons.pending_outlined,
                                        color: p.selesai ? Colors.green : null,
                                      ),
                                      title: Text(p.layanan),
                                      subtitle: Text(
                                        '${p.nama} - ${p.bidang}\n'
                                        '${p.selesai ? 'Selesai ditindaklanjuti' : 'Menunggu tindak lanjut'}',
                                      ),
                                      isThreeLine: true,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _ajukanBaru(context),
        tooltip: 'Pengajuan baru',
        child: const Icon(Icons.add),
      ),
    );
  }
}
