import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spp/models/login/LoginModel.dart';
import 'package:spp/res/theme/colors/light_colors.dart';
import 'package:spp/res/widgets/top_container.dart';
import 'package:spp/view/login/login.dart';
import 'package:spp/view/monitoring/health.dart';
import 'package:spp/view/monitoring/spp.dart';
import 'package:spp/view/pengaturan/pengaturan.dart';

import '../../data/remote/response/Status.dart';
import '../../res/widgets/active_project_card.dart';
import '../../res/widgets/task_column.dart';
import '../../view_model/login/LoginVM.dart';
import 'package:provider/provider.dart';

import '../monitoring/hafalan.dart';
import '../widget/LoadingWidget.dart';
import '../widget/MyErrorWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _home();
}

class _home extends State<home> {
  final LoginVM viewModel = LoginVM();
  String? nama = '';

  get width => null;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    dynamic id = await SessionManager().get("id");
    if (id != null) {
      await viewModel.DetailAccount(id.toString());
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => login()));
    }
  }

  Future<void> _dialoglogout(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Apakah anda yakin akan keluar Aplikasi ?'),
          content: const Text(
              'Jika iya tekan YA jika tidak tekan TIDAK, Jika Logout anda harus login kembali jika akan menggunakan Aplikasi'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ya'),
              onPressed: () async {
                await SessionManager().remove("id").then((value) =>
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => login()),
                        ModalRoute.withName('/')));
              },
            ),
          ],
        );
      },
    );
  }

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  GestureDetector calendarIcon() {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pengaturan(),
          ),
        ).whenComplete(() => {getdata()});
      },
      child: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.settings,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _dialoglogout(context);
            },
          )
        ],
        backgroundColor: LightColors.Blue,
        title: Text("Kontrol Anak"),
      ),
      backgroundColor: Colors.white,
      body: ChangeNotifierProvider<LoginVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<LoginVM>(builder: (context, viewModel, _) {
          switch (viewModel.login.status) {
            case Status.LOADING:
              return LoadingWidget();
            case Status.ERROR:
              return MyErrorWidget(viewModel.login.message ?? "NA");
            case Status.COMPLETED:
              return getDataHome(viewModel.login.data!.data!);
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Widget getDataHome(Data data) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopContainer(
            height: 200,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircularPercentIndicator(
                          radius: 40.0,
                          lineWidth: 5.0,
                          animation: true,
                          percent: 0.75,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Color.fromARGB(255, 255, 255, 255),
                          backgroundColor: Color.fromARGB(255, 243, 206, 137),
                          center: CircleAvatar(
                            backgroundColor: LightColors.kBlue,
                            radius: 35.0,
                            backgroundImage: NetworkImage(
                                "https://spp.kanalapps.web.id/public/images/wali/" +
                                    data.foto!),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                data.nama!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                data.alamat!,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            subheading('BequranicApp'),
                            GestureDetector(
                              onTap: () {},
                              child: calendarIcon(),
                            ),
                          ],
                        ),
                        /*SizedBox(height: 15.0),
                        TaskColumn(
                          widget: home(),
                          jenis: 'url',
                          url: '',
                          icon: Icons.person,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Total Santri',
                          subtitle: 'Total Santri Aktif',
                        ),*/
                        SizedBox(
                          height: 15.0,
                        ),
                        TaskColumn(
                          widget: home(),
                          jenis: "url",
                          url:
                              'https://www.google.com/maps/search/?api=1&query=1.5058823,102.0624475',
                          icon: Icons.maps_home_work_sharp,
                          iconBackgroundColor: LightColors.kDarkYellow,
                          title: 'Lokasi BeQuranic',
                          subtitle: 'Klick untuk membuka Peta',
                        ),
                        SizedBox(height: 15.0),
                        TaskColumn(
                          widget: hafalan(anak: viewModel.login.data!.anak),
                          jenis: 'route',
                          url: '',
                          icon: Icons.announcement,
                          iconBackgroundColor: LightColors.kBlue,
                          title: 'Hafalan Anak',
                          subtitle: 'Yuk Pantau Hafalan Anak Anda',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        subheading('Fitur Aplikasi'),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => spp(
                                            anak: viewModel.login.data!.anak),
                                      ),
                                    ),
                                child: Container(
                                    width: 160,
                                    child: ActiveProjectsCard(
                                      cardColor: LightColors.kGreen,
                                      loadingPercent: 0.25,
                                      title: 'SPP',
                                      subtitle:
                                          'Monitoring Pembayaran SPP anak',
                                      icon: Icons.money_sharp,
                                    ))),
                            SizedBox(width: 20.0),
                            GestureDetector(
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => health(
                                            anak: viewModel.login.data!.anak),
                                      ),
                                    ),
                                child: Container(
                                    width: 160,
                                    child: ActiveProjectsCard(
                                      cardColor: LightColors.kRed,
                                      loadingPercent: 0.6,
                                      title: 'Kesehatan',
                                      subtitle: 'Monitoring Kesehatan anak',
                                      icon: Icons.health_and_safety,
                                    )))
                          ],
                        ),
                      ],
                    ),
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
