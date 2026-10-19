enum SesiKunjungan {
  pagi('Pagi'),
  siang('Siang'),
  sore('Sore');

  const SesiKunjungan(this.label);
  final String label;
}

class Pengajuan {
  const Pengajuan({
    required this.id,
    required this.layanan,
    required this.bidang,
    required this.nama,
    required this.email,
    required this.sesi,
    required this.waktu,
    this.selesai = false,
  });

  final int id;
  final String layanan;
  final String bidang;
  final String nama;
  final String email;
  final SesiKunjungan sesi;
  final DateTime waktu;
  final bool selesai;

  Pengajuan copyWith({bool? selesai}) => Pengajuan(
    id: id,
    layanan: layanan,
    bidang: bidang,
    nama: nama,
    email: email,
    sesi: sesi,
    waktu: waktu,
    selesai: selesai ?? this.selesai,
  );
}
