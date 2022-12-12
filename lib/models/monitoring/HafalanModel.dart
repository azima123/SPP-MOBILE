class HafalanModel {
  String? message;
  List<Datahafalan>? data;

  HafalanModel({required this.message, required this.data});

  HafalanModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Datahafalan>[];
      json['data'].forEach((v) {
        data!.add(new Datahafalan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datahafalan {
  String? idSiswa;
  String? nis;
  String? nama;
  String? tptLahir;
  String? tglLahir;
  String? idKelas;
  String? namaIbu;
  String? foto;
  String? alamat;
  String? idSekolahsiswa;
  String? idtahunmasuksiswa;
  String? statussiswa;
  String? createdAt;
  String? updatedAt;
  String? kelas;
  String? idSekolahkelas;
  String? idSekolah;
  String? nmSekolah;
  String? alSekolah;
  String? kecamatan;
  String? kabupaten;
  String? nmKepsek;
  String? logo;
  String? nipKepsek;
  String? bendahara;
  String? nipbendahara;
  String? website;
  String? email;
  String? nohp;
  //int? id;
  String? batasHafalan;
  String? tglSetor;

  Datahafalan(
      {this.idSiswa,
      this.nis,
      this.nama,
      this.tptLahir,
      this.tglLahir,
      this.idKelas,
      this.namaIbu,
      this.foto,
      this.alamat,
      this.idSekolahsiswa,
      this.idtahunmasuksiswa,
      this.statussiswa,
      this.createdAt,
      this.updatedAt,
      this.kelas,
      this.idSekolahkelas,
      this.idSekolah,
      this.nmSekolah,
      this.alSekolah,
      this.kecamatan,
      this.kabupaten,
      this.nmKepsek,
      this.logo,
      this.nipKepsek,
      this.bendahara,
      this.nipbendahara,
      this.website,
      this.email,
      this.nohp,
      //this.id,
      this.batasHafalan,
      this.tglSetor});

  Datahafalan.fromJson(Map<String, dynamic> json) {
    idSiswa = json['id_siswa'];
    nis = json['nis'];
    nama = json['nama'];
    tptLahir = json['tpt_lahir'];
    tglLahir = json['tgl_lahir'];
    idKelas = json['id_kelas'];
    namaIbu = json['nama_ibu'];
    foto = json['foto'];
    alamat = json['alamat'];
    idSekolahsiswa = json['id_sekolahsiswa'];
    idtahunmasuksiswa = json['idtahunmasuksiswa'];
    statussiswa = json['statussiswa'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kelas = json['kelas'];
    idSekolahkelas = json['id_sekolahkelas'];
    idSekolah = json['id_sekolah'];
    nmSekolah = json['nm_sekolah'];
    alSekolah = json['al_sekolah'];
    kecamatan = json['kecamatan'];
    kabupaten = json['kabupaten'];
    nmKepsek = json['nm_kepsek'];
    logo = json['logo'];
    nipKepsek = json['nip_kepsek'];
    bendahara = json['bendahara'];
    nipbendahara = json['nipbendahara'];
    website = json['website'];
    email = json['email'];
    nohp = json['nohp'];
    //id = json['id'];
    batasHafalan = json['batas_hafalan'];
    tglSetor = json['tgl_setor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_siswa'] = this.idSiswa;
    data['nis'] = this.nis;
    data['nama'] = this.nama;
    data['tpt_lahir'] = this.tptLahir;
    data['tgl_lahir'] = this.tglLahir;
    data['id_kelas'] = this.idKelas;
    data['nama_ibu'] = this.namaIbu;
    data['foto'] = this.foto;
    data['alamat'] = this.alamat;
    data['id_sekolahsiswa'] = this.idSekolahsiswa;
    data['idtahunmasuksiswa'] = this.idtahunmasuksiswa;
    data['statussiswa'] = this.statussiswa;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['kelas'] = this.kelas;
    data['id_sekolahkelas'] = this.idSekolahkelas;
    data['id_sekolah'] = this.idSekolah;
    data['nm_sekolah'] = this.nmSekolah;
    data['al_sekolah'] = this.alSekolah;
    data['kecamatan'] = this.kecamatan;
    data['kabupaten'] = this.kabupaten;
    data['nm_kepsek'] = this.nmKepsek;
    data['logo'] = this.logo;
    data['nip_kepsek'] = this.nipKepsek;
    data['bendahara'] = this.bendahara;
    data['nipbendahara'] = this.nipbendahara;
    data['website'] = this.website;
    data['email'] = this.email;
    data['nohp'] = this.nohp;
    //data['id'] = this.id;
    data['batas_hafalan'] = this.batasHafalan;
    data['tgl_setor'] = this.tglSetor;
    return data;
  }
}
