import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/pengajuan_model.dart';

class PengajuanState {
  const PengajuanState({this.semua = const [], this.idTerakhir = 0});

  static const daftarBidang = ['Perizinan', 'Kesehatan', 'Transportasi'];

  final List<Pengajuan> semua;
  final int idTerakhir;

  // Terbaru di atas
  List<Pengajuan> get daftar => semua.reversed.toList();

  int get totalPengajuan => semua.length;

  Map<String, int> get jumlahPerBidang => {
    for (final b in daftarBidang) b: semua.where((p) => p.bidang == b).length,
  };

  Pengajuan? cari(int id) {
    for (final p in semua) {
      if (p.id == id) return p;
    }
    return null;
  }
}

class PengajuanCubit extends Cubit<PengajuanState> {
  PengajuanCubit() : super(const PengajuanState());

  void tambah({
    required String layanan,
    required String bidang,
    required String nama,
    required String email,
    required SesiKunjungan sesi,
  }) {
    final id = state.idTerakhir + 1;
    emit(
      PengajuanState(
        idTerakhir: id,
        semua: [
          ...state.semua,
          Pengajuan(
            id: id,
            layanan: layanan,
            bidang: bidang,
            nama: nama,
            email: email,
            sesi: sesi,
            waktu: DateTime.now(),
          ),
        ],
      ),
    );
  }

  void tandaiSelesai(int id) {
    final p = state.cari(id);
    if (p == null || p.selesai) return;
    emit(
      PengajuanState(
        idTerakhir: state.idTerakhir,
        semua: [
          for (final e in state.semua)
            e.id == id ? e.copyWith(selesai: true) : e,
        ],
      ),
    );
  }
}
