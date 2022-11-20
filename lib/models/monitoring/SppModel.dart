class SppModel {
  String? message;
  List<Dataspp>? data;

  SppModel({required this.message, required this.data});

  SppModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Dataspp>[];
      json['data'].forEach((v) {
        data!.add(new Dataspp.fromJson(v));
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

class Dataspp {
  String? bulan;
  String? bayar;
  String? status;

  Dataspp({required this.bulan, required this.bayar, required this.status});

  Dataspp.fromJson(Map<String, dynamic> json) {
    bulan = json['bulan'];
    bayar = json['bayar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bulan'] = this.bulan;
    data['bayar'] = this.bayar as String;
    data['status'] = this.status;
    return data;
  }
}
