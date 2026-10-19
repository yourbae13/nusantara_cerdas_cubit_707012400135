import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../navigation/app_routes.dart';
import 'layanan_data.dart';

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  Future<void> _buka(BuildContext context, Layanan l) async {
    final hasil = await Navigator.pushNamed<String>(
      context,
      AppRoutes.rincian,
      arguments: l,
    );
    if (hasil != null && context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(hasil)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final kelompok = dataLayanan.keys.toList();
    return DefaultTabController(
      length: kelompok.length,
      child: Column(
        children: [
          TabBar(tabs: [for (final k in kelompok) Tab(text: k)]),
          Expanded(
            child: TabBarView(
              children: [
                for (final k in kelompok)
                  ListView(
                    children: [
                      for (final l in dataLayanan[k]!)
                        ListTile(
                          leading: const Icon(Icons.description_outlined),
                          title: Text(l.nama),
                          subtitle: Text(l.dinas),
                          trailing:
                              BlocSelector<FavoritCubit, Set<String>, bool>(
                                selector: (favorit) => favorit.contains(l.nama),
                                builder: (context, fav) {
                                  return IconButton(
                                    tooltip: fav
                                        ? 'Hapus dari favorit'
                                        : 'Tandai favorit',
                                    icon: Icon(
                                      fav ? Icons.star : Icons.star_border,
                                    ),
                                    color: fav ? Colors.amber : null,
                                    onPressed: () {
                                      final cubit = context
                                          .read<FavoritCubit>();
                                      if (fav) {
                                        cubit.batalTandai(l.nama);
                                      } else {
                                        cubit.tandai(l.nama);
                                      }
                                    },
                                  );
                                },
                              ),
                          onTap: () => _buka(context, l),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
