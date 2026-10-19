import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pengajuan_cubit.dart';

class IkonWargaBadge extends StatelessWidget {
  const IkonWargaBadge({super.key, required this.ikon});
  final IconData ikon;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PengajuanCubit, PengajuanState, int>(
      selector: (state) => state.totalPengajuan,
      builder: (context, total) => Badge(
        isLabelVisible: total > 0,
        label: Text('$total'),
        child: Icon(ikon),
      ),
    );
  }
}
