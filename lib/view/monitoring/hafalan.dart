import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spp/models/login/LoginModel.dart';
import 'package:spp/models/monitoring/HafalanModel.dart';
import 'package:spp/view_model/hafalan/HafalanVM.dart';

import '../../data/remote/response/Status.dart';
import '../../res/theme/colors/light_colors.dart';
import '../widget/LoadingWidget.dart';
import '../widget/MyErrorWidget.dart';

class hafalan extends StatefulWidget {
  final anak;
  const hafalan({Key? key, this.anak}) : super(key: key);

  @override
  State<hafalan> createState() => _hafalan();
}

class _hafalan extends State<hafalan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitoring Hafalan"),
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
            builder: (context) => DetailHafalan(
                idkelas: item.idKelas!,
                idsekolah: item.idSekolahsiswa!,
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

class DetailHafalan extends StatefulWidget {
  final idsekolah;
  final idkelas;
  final nis;
  const DetailHafalan({
    Key? key,
    this.idkelas,
    this.idsekolah,
    this.nis,
  }) : super(key: key);

  @override
  State<DetailHafalan> createState() => _detailhafalan();
}

class _detailhafalan extends State<DetailHafalan> {
  HafalanVM viewmodel = HafalanVM();
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    await viewmodel.getlisthafalan(
        widget.idkelas.toString(), widget.idsekolah.toString(), widget.nis);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Hafalan Siswa"),
        backgroundColor: LightColors.Blue,
      ),
      body: ChangeNotifierProvider<HafalanVM>(
        create: (BuildContext context) => viewmodel,
        child: Consumer<HafalanVM>(builder: (context, viewModel, _) {
          switch (viewModel.hafalan.status) {
            case Status.LOADING:
              return LoadingWidget();
            case Status.ERROR:
              return MyErrorWidget(viewModel.hafalan.message ?? "NA");
            case Status.COMPLETED:
              return getDatalist(viewModel.hafalan.data!.data!);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget getDatalist(List<Datahafalan> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, position) {
          return _getlistItem(list[position]);
        });
  }

  Widget _getlistItem(Datahafalan item) {
    return Card(
        margin: EdgeInsets.only(top: 2),
        child: ListTile(
          title: Text(item.batasHafalan!),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("Tgl Setor : " + item.tglSetor!)],
          ),
        ));
  }
}
