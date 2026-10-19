import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pengajuan_cubit.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PengajuanCubit, PengajuanState>(
      builder: (context, state) => _isi(context, state.jumlahPerBidang),
    );
  }

  Widget _isi(BuildContext context, Map<String, int> data) {
    final bidang = data.keys.toList();
    final nilai = data.values.toList();
    final tertinggi = nilai.fold(0, (a, b) => a > b ? a : b);
    final total = nilai.fold(0, (a, b) => a + b);
    final warna = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jumlah Pengajuan per Bidang',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text('Total: $total pengajuan'),
          const SizedBox(height: 24),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: (tertinggi + 1).toDouble(),
                alignment: BarChartAlignment.spaceAround,
                gridData: const FlGridData(drawVerticalLine: false),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 1,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        final i = v.toInt();
                        if (i < 0 || i >= bidang.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(bidang[i]),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (var i = 0; i < nilai.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: nilai[i].toDouble(),
                          width: 32,
                          color: warna,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
