import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:provider/provider.dart';
import 'package:spp/res/widgets/display_profil.dart';

import '../../data/remote/response/Status.dart';
import '../../models/login/LoginModel.dart';
import '../../res/theme/colors/light_colors.dart';
import '../../view_model/login/LoginVM.dart';
import '../widget/LoadingWidget.dart';
import '../widget/MyErrorWidget.dart';

class pengaturan extends StatefulWidget {
  const pengaturan({Key? key}) : super(key: key);
  @override
  State<pengaturan> createState() => _pengaturan();
}

class _pengaturan extends State<pengaturan> {
  final LoginVM viewModel = LoginVM();
  String? nama, email, alamat, nohp;
  final _key = new GlobalKey<FormState>();
  File? image;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  void refresdata() {
    setState(() {
      getdata();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Update Berhasil!'),
        ),
      );
    });
  }

  check() async {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      final Map<String, String> Datas;

      Datas = {
        'id': viewModel.login.data!.data!.id.toString(),
        'nama': nama!,
        'email': email!,
        'alamat': alamat!,
        'nohp': nohp!,
        'foto': image != null
            ? 'data:image/png;base64,' + base64Encode(image!.readAsBytesSync())
            : '',
      };
      await viewModel.UpdateAccount(Datas).whenComplete(() => {refresdata()});
    }
  }

  Future openCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    //image = File(pickedImage!.path);
    setState(() {
      image = File(pickedImage!.path);
    });
  }

  Future openGallery() async {
    final imageGallery =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(imageGallery!.path);
    });
  }

  getdata() async {
    dynamic id = await SessionManager().get("id");
    await viewModel.DetailAccount(id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan Akun"),
        backgroundColor: LightColors.Blue,
      ),
      body: _bodywidget(),
    );
  }

  Widget _bodywidget() {
    return ChangeNotifierProvider<LoginVM>(
      create: (BuildContext context) => viewModel,
      child: Consumer<LoginVM>(builder: (context, viewModel, _) {
        switch (viewModel.login.status) {
          case Status.LOADING:
            return LoadingWidget();
          case Status.ERROR:
            return MyErrorWidget(viewModel.login.message ?? "NA");
          case Status.COMPLETED:
            if (viewModel.login.data?.data != null) {
              return getDataProfil(viewModel.login.data!.data!);
            } else {
              getdata();
            }
            break;

          default:
        }
        return Container();
      }),
    );
  }

  Widget getDataProfil(Data data) {
    return SafeArea(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
                child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  Center(
                      child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  )),
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder) => Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  children: [
                                    Text(
                                      'Choose Profile Photo',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FlatButton.icon(
                                          icon: Icon(Icons.camera),
                                          onPressed: () {
                                            openCamera();
                                          },
                                          label: Text('Camera'),
                                        ),
                                        FlatButton.icon(
                                          icon: Icon(Icons.image),
                                          onPressed: () {
                                            openGallery();
                                          },
                                          label: Text('Gallery'),
                                        )
                                      ],
                                    )
                                  ],
                                ))));
                      },
                      child: image != null
                          ? CircleAvatar(
                              backgroundImage: new FileImage(image!),
                              radius: 75,
                              backgroundColor: Color.fromRGBO(64, 105, 225, 1),
                            )
                          : Displayprofil(
                              imagePath:
                                  'https://spp.kanalapps.web.id/public/images/wali/' +
                                      data.foto!,
                              onPressed: () {},
                            )),
                  /* buildUserInfoDisplay(user.name, 'Name', EditNameFormPage()),
          buildUserInfoDisplay(user.phone, 'Phone', EditPhoneFormPage()),
          buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
          Expanded(
            child: buildAbout(user),
            flex: 4,
          )*/
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Nama lengkap harus diisi";
                      }
                    },
                    onSaved: (e) => nama = e,
                    initialValue: data.nama!,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nama Lengkap",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Email harus diisi";
                      }
                    },
                    onSaved: (e) => email = e,
                    initialValue: data.email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email Pengguna",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "Alamat harus diisi";
                      }
                    },
                    onSaved: (e) => alamat = e,
                    initialValue: data.alamat,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Alamat",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (e) {
                      if (e!.isEmpty) {
                        return "NO HP harus diisi";
                      }
                    },
                    onSaved: (e) => nohp = e,
                    initialValue: data.nohp,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "No HP",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonTheme(
                    buttonColor: Colors.amber,
                    minWidth: MediaQuery.of(context).size.width,
                    height: 50,
                    child: RaisedButton(
                      onPressed: () {
                        check();
                      },
                      child: Text("UPDATE PROFIL"),
                    ),
                  )
                ],
              ),
            ))));
  }
}
