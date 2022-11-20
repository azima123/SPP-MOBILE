import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spp/models/login/LoginModel.dart';
import 'package:spp/models/monitoring/KesehatanModel.dart';

import '../../data/remote/response/Status.dart';
import '../../res/theme/colors/light_colors.dart';
import '../../view_model/helath/HealthVM.dart';
import '../widget/LoadingWidget.dart';
import '../widget/MyErrorWidget.dart';

class health extends StatefulWidget {
  final anak;
  const health({Key? key, this.anak}) : super(key: key);

  @override
  State<health> createState() => _health();
}

class _health extends State<health> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitoring Kesehatan"),
        backgroundColor: LightColors.Blue,
      ),
      body: _widgetbody(widget.anak),
    );
  }

  Widget _widgetbody(List<Anak>? Listanak) {
    return ListView.builder(
        itemCount: Listanak?.length,
        itemBuilder: (context, position) {
          return _getAnakListItem(Listanak![position]);
        });
  }

  Widget _getAnakListItem(Anak item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailHealth(
                idkelas: item.idKelas!,
                idsekolah: item.idSekolahsiswa,
                nis: item.nis),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(top: 2),
        child: ListTile(
          title: Text(item.nama!),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("NIS : " + item.nis!),
              Text("kelas :" + item.kelas!),
              Text("Alamat :" + item.alamat!)
            ],
          ),
        ),
      ),
    );
  }
}

class DetailHealth extends StatefulWidget {
  final idkelas;
  final idsekolah;
  final nis;
  const DetailHealth({
    Key? key,
    this.idkelas,
    this.idsekolah,
    this.nis,
  }) : super(key: key);

  @override
  State<DetailHealth> createState() => _detailhealth();
}

class _detailhealth extends State<DetailHealth> {
  final HealthVM viewModel = HealthVM();
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await viewModel.getlisthealth(
        widget.idkelas.toString(), widget.idsekolah.toString(), widget.nis);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Checkup Siswa"),
        backgroundColor: LightColors.Blue,
      ),
      body: ChangeNotifierProvider<HealthVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<HealthVM>(builder: (context, viewModel, _) {
          switch (viewModel.health.status) {
            case Status.LOADING:
              return LoadingWidget();
            case Status.ERROR:
              return MyErrorWidget(viewModel.health.message ?? "NA");
            case Status.COMPLETED:
              return getDatalist(viewModel.health.data!.data!);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget getDatalist(List<Datakesehatan> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, position) {
          return _getlistItem(list[position]);
        });
  }

  Widget _getlistItem(Datakesehatan item) {
    return Card(
        margin: EdgeInsets.only(top: 2),
        child: ListTile(
          title: Text(item.kesehatan!),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Tgl Check : " + item.tglCheckup!)],
          ),
        ));
  }
}
