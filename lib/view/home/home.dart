import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:spp/models/login/LoginModel.dart';
import 'package:spp/res/theme/colors/light_colors.dart';
import 'package:spp/res/widgets/top_container.dart';

import '../../data/remote/response/Status.dart';
import '../../res/widgets/active_project_card.dart';
import '../../res/widgets/task_column.dart';
import '../../view_model/login/LoginVM.dart';
import 'package:provider/provider.dart';

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
    await viewModel.DetailAccount(id.toString());
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

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                            backgroundImage: AssetImage(
                              'assets/images/avatar.png',
                            ),
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
                        SizedBox(height: 15.0),
                        TaskColumn(
                          jenis: 'route',
                          url: '',
                          icon: Icons.person,
                          iconBackgroundColor: LightColors.kRed,
                          title: 'Total Santri',
                          subtitle: 'Total Santri Aktif',
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TaskColumn(
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
                          jenis: 'route',
                          url: '',
                          icon: Icons.announcement,
                          iconBackgroundColor: LightColors.kBlue,
                          title: 'Pengumuman',
                          subtitle: 'Pengumuman Bequranic',
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
                                onTap: () => Navigator.pushNamed(
                                    context, 'monitoringspp'),
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
                                onTap: () => Navigator.pushNamed(
                                    context, 'monitoringhealth'),
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
