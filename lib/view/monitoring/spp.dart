import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spp/models/login/LoginModel.dart';
import 'package:spp/models/monitoring/SppModel.dart';
import 'package:spp/res/theme/colors/light_colors.dart';
import 'package:spp/view_model/spp/SppVM.dart';

import '../../data/remote/response/Status.dart';
import '../../view_model/login/LoginVM.dart';
import '../widget/LoadingWidget.dart';
import '../widget/MyErrorWidget.dart';

class spp extends StatefulWidget {
  final anak;
  const spp({Key? key, this.anak}) : super(key: key);

  @override
  State<spp> createState() => _spp();
}

class _spp extends State<spp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitoring SPP"),
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
            builder: (context) => DetailSPP(nis: item.nis!),
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

class DetailSPP extends StatefulWidget {
  final String nis;
  const DetailSPP({Key? key, required this.nis}) : super(key: key);

  @override
  State<DetailSPP> createState() => _DetailSpp();
}

class _DetailSpp extends State<DetailSPP> {
  final SppVM viewModel = SppVM();

  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    await viewModel.getlistpay(widget.nis);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.Blue,
        title: Text("Pembayaran SPP"),
      ),
      body: ChangeNotifierProvider<SppVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<SppVM>(builder: (context, viewModel, _) {
          switch (viewModel.spp.status) {
            case Status.LOADING:
              return LoadingWidget();
            case Status.ERROR:
              return MyErrorWidget(viewModel.spp.message ?? "NA");
            case Status.COMPLETED:
              return getData(viewModel.spp.data!.data!);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget getData(List<Dataspp> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, position) {
          return _getPaytItem(list[position]);
        });
  }
}

Widget _getPaytItem(Dataspp item) {
  return Card(
      margin: EdgeInsets.only(top: 2),
      child: ListTile(
        title: Text(item.bulan!),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pembayaran : " + item.bayar!),
            Text("Status: " + item.status!)
          ],
        ),
      ));
}
