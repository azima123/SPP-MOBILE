class LoginModel {
  String? message;
  Data? data;
  List<Anak>? anak;

  LoginModel({required this.message, required this.data, required this.anak});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    if (json['anak'] != null) {
      anak = <Anak>[];
      json['anak'].forEach((v) {
        anak!.add(new Anak.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.anak != null) {
      data['anak'] = this.anak!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? nama;
  String? nohp;
  String? alamat;
  String? email;
  int? idSekolah;
  String? password;
  String? createdAt;
  String? updatedAt;
  String? idSiswa;

  Data(
      {required this.id,
      required this.nama,
      required this.nohp,
      required this.alamat,
      required this.email,
      required this.idSekolah,
      required this.password,
      required this.createdAt,
      required this.updatedAt,
      required this.idSiswa});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nohp = json['nohp'];
    alamat = json['alamat'];
    email = json['email'];
    idSekolah = json['id_sekolah'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idSiswa = json['id_siswa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['nohp'] = this.nohp;
    data['alamat'] = this.alamat;
    data['email'] = this.email;
    data['id_sekolah'] = this.idSekolah;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id_siswa'] = this.idSiswa;
    return data;
  }
}

class Anak {
  int? idSiswa;
  String? nis;
  String? nama;
  String? tptLahir;
  String? tglLahir;
  int? idKelas;
  String? namaIbu;
  String? foto;
  String? alamat;
  int? idSekolahsiswa;
  int? idtahunmasuksiswa;
  String? statussiswa;
  String? createdAt;
  String? updatedAt;

  Anak(
      {required this.idSiswa,
      required this.nis,
      required this.nama,
      required this.tptLahir,
      required this.tglLahir,
      required this.idKelas,
      required this.namaIbu,
      required this.foto,
      required this.alamat,
      required this.idSekolahsiswa,
      required this.idtahunmasuksiswa,
      required this.statussiswa,
      required this.createdAt,
      required this.updatedAt});

  Anak.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
