import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/api/form_user_api_listener.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../api/form_user_api_services.dart';
import '../componets/custom_dialog_information.dart';
import '../componets/custom_loader.dart';
import '../models/user_model.dart';
import '../componets/custom_dialog_question.dart';
import '../controllers/form_user_controller.dart';
import '../helper/constants.dart';
import '../helper/screen.dart';

class FormUserPage extends StatelessWidget {
  final UserModel? data;
  const FormUserPage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: GetBuilder<FormUserController>(
          init: FormUserController(),
          initState: (_) {
            if (data != null) {
              final myC = Get.put(FormUserController());
              myC.onSetDataUser(data!);
            }
          },
          builder: (c) {
            return Text(
              c.dataUser == null ? "Tambah Data User" : "Ubah Data User",
              style: TextStyle(
                fontSize: size.getWidthPx(14),
              ),
            );
          },
        ),
      ),
      body: Container(
        color: Constants.BACKGROUND_COLOR,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: const [
            InputFullName(),
            InputShortName(),
            InputPhonenumber(),
            InputEmail(),
            InputGender(),
            InputAddress(),
            InputJob(),
            ButtonSave(),
          ],
        ),
      ),
    );
  }
}

class InputFullName extends StatelessWidget {
  const InputFullName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: GetBuilder<FormUserController>(
        builder: (c) {
          return TextField(
            controller: c.inputFullName,
            cursorColor: const Color(0xFF0D47A1),
            style: TextStyle(
              fontSize: size.getWidthPx(14),
              color: Colors.grey.shade800,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(
                0.0,
                0.0,
                0.0,
                0.0,
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF0D47A1)),
              ),
              labelText: "Nama Lengkap",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: size.getWidthPx(14),
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              errorText: !c.validateFullName ? c.msgFullName : null,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontSize: size.getWidthPx(10),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InputShortName extends StatelessWidget {
  const InputShortName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: GetBuilder<FormUserController>(
        builder: (c) {
          return TextField(
            controller: c.inputShortName,
            cursorColor: const Color(0xFF0D47A1),
            style: TextStyle(
              fontSize: size.getWidthPx(14),
              color: Colors.grey.shade800,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(
                0.0,
                0.0,
                0.0,
                0.0,
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF0D47A1)),
              ),
              labelText: "Nama Panggilan",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: size.getWidthPx(14),
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              errorText: !c.validateShortName ? c.msgShortName : null,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontSize: size.getWidthPx(10),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InputPhonenumber extends StatelessWidget {
  const InputPhonenumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: GetBuilder<FormUserController>(
        builder: (c) {
          return TextField(
            controller: c.inputPhonenumber,
            cursorColor: const Color(0xFF0D47A1),
            style: TextStyle(
              fontSize: size.getWidthPx(14),
              color: Colors.grey.shade800,
            ),
            autofocus: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(
                0.0,
                0.0,
                0.0,
                0.0,
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF0D47A1)),
              ),
              labelText: "Nomor Handphone",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: size.getWidthPx(14),
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              errorText: !c.validatePhonenumber ? c.msgPhonenumber : null,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontSize: size.getWidthPx(10),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InputEmail extends StatelessWidget {
  const InputEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: GetBuilder<FormUserController>(
        builder: (c) {
          return TextField(
            controller: c.inputEmail,
            cursorColor: const Color(0xFF0D47A1),
            style: TextStyle(
              fontSize: size.getWidthPx(14),
              color: Colors.grey.shade800,
            ),
            autofocus: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(
                0.0,
                0.0,
                0.0,
                0.0,
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF0D47A1)),
              ),
              labelText: "Email",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: size.getWidthPx(14),
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              errorText: !c.validateEmail ? c.msgEmail : null,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontSize: size.getWidthPx(10),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InputGender extends StatelessWidget {
  const InputGender({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return GetBuilder<FormUserController>(
      builder: (c) {
        return InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Get.bottomSheet(
              Container(
                color: Colors.white,
                child: Wrap(
                  children: <Widget>[
                    ItemOptionGender(
                      icon: MdiIcons.faceMan,
                      title: "Laki-Laki",
                      action: () {
                        c.onSelectGender("Laki-Laki");
                      },
                    ),
                    ItemOptionGender(
                      icon: MdiIcons.faceWoman,
                      title: "Perempuan",
                      action: () {
                        c.onSelectGender("Perempuan");
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.only(top: size.getWidthPx(16)),
            padding: EdgeInsets.symmetric(
              horizontal: size.getWidthPx(16),
            ),
            child: TextField(
              controller: c.inputGender,
              cursorColor: const Color(0xFF0D47A1),
              style: TextStyle(
                fontSize: size.getWidthPx(14),
                color: Colors.grey.shade800,
              ),
              autofocus: false,
              enabled: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(
                  0.0,
                  0.0,
                  0.0,
                  0.0,
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0D47A1)),
                ),
                labelText: "Jenis Kelamin",
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: size.getWidthPx(14),
                ),
                floatingLabelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: size.getWidthPx(14),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                errorText: !c.validateGender ? c.msgGender : null,
                errorStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontStyle: FontStyle.italic,
                  fontSize: size.getWidthPx(10),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ItemOptionGender extends StatelessWidget {
  final dynamic action;
  final String title;
  final IconData icon;

  const ItemOptionGender({
    Key? key,
    required this.action,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey[700],
        size: size.getWidthPx(25),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: size.getWidthPx(16),
        ),
      ),
      onTap: () async {
        Get.back();
        action();
      },
    );
  }
}

class InputAddress extends StatelessWidget {
  const InputAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: GetBuilder<FormUserController>(
        builder: (c) {
          return TextField(
            controller: c.inputAddress,
            cursorColor: const Color(0xFF0D47A1),
            style: TextStyle(
              fontSize: size.getWidthPx(14),
              color: Colors.grey.shade800,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(
                0.0,
                0.0,
                0.0,
                0.0,
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF0D47A1)),
              ),
              labelText: "Alamat",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: size.getWidthPx(14),
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              errorText: !c.validateAddress ? c.msgAddress : null,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontSize: size.getWidthPx(10),
              ),
            ),
          );
        },
      ),
    );
  }
}

class InputJob extends StatelessWidget {
  const InputJob({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(top: size.getWidthPx(16)),
      padding: EdgeInsets.symmetric(
        horizontal: size.getWidthPx(16),
      ),
      child: GetBuilder<FormUserController>(
        builder: (c) {
          return TextField(
            controller: c.inputJob,
            cursorColor: const Color(0xFF0D47A1),
            style: TextStyle(
              fontSize: size.getWidthPx(14),
              color: Colors.grey.shade800,
            ),
            autofocus: false,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(
                0.0,
                0.0,
                0.0,
                0.0,
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF0D47A1)),
              ),
              labelText: "Pekerjaan",
              labelStyle: TextStyle(
                color: Colors.grey,
                fontSize: size.getWidthPx(14),
              ),
              floatingLabelStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              errorText: !c.validateJob ? c.msgJob : null,
              errorStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontSize: size.getWidthPx(10),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ButtonSave extends StatelessWidget implements FormUserApiListener {
  const ButtonSave({
    Key? key,
  }) : super(key: key);

  onSubmitData() {
    final myC = Get.find<FormUserController>();
    Get.dialog(const CustomLoader());
    String valueFullName = myC.inputFullName.text.toString().trim();
    String valueShortName = myC.inputShortName.text.toString().trim();
    String valuePhonenumber = myC.inputPhonenumber.text.toString().trim();
    String valueEmail = myC.inputEmail.text.toString().trim();
    String valueGender = myC.inputGender.text.toString().trim();
    String valueAddress = myC.inputAddress.text.toString().trim();
    String valueJob = myC.inputJob.text.toString().trim();
    String? userId = "0";

    if (myC.dataUser != null) {
      userId = myC.dataUser?.userId;
    }

    FormUserApiServices(this).postFormUser(
      userId.toString(),
      valueFullName,
      valueShortName,
      valuePhonenumber,
      valueEmail,
      valueGender,
      valueAddress,
      valueJob,
    );
  }

  onValidationFormInput() async {
    final myC = Get.find<FormUserController>();
    bool result = await myC.onValidationFormInput();
    if (result) {
      Get.dialog(
        CustomDialogQuestion(
          title: "",
          onTapOke: () async {
            Get.back();
            onSubmitData();
          },
          desc: myC.dataUser == null
              ? "Apakahan Anda yakin ingin menambahkan data user ?"
              : "Apakahan Anda yakin ingin menyimpan perubahan data user ?",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(
        top: size.getWidthPx(32),
        bottom: size.getWidthPx(32),
        left: size.getWidthPx(16),
        right: size.getWidthPx(16),
      ),
      child: GetBuilder<FormUserController>(
        builder: (c) {
          return ElevatedButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              onValidationFormInput();
            },
            child: Text(
              c.dataUser == null ? "Simpan Data" : "Simpan Perubahan Data",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size.getWidthPx(14),
              ),
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.infinity, size.getWidthPx(40)),
              primary: Colors.blue[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(
                vertical: size.getWidthPx(10),
                horizontal: size.getWidthPx(14),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  onFormUserFailure(response, statusCode) {
    Get.back();
    Get.dialog(
      CustomDialogInformation(
        onTap: () {
          Get.back();
        },
        title: "Failed",
        desc: "${response['message']}",
        color: Colors.red,
        icon: Icons.error_outline,
      ),
    );
  }

  @override
  onFormUserSuccess(response, statusCode) {
    Get.back();
    if (response['status'] == 200) {
      Get.back(result: response);
      Get.dialog(
        CustomDialogInformation(
          onTap: () {
            Get.back();
          },
          title: "${response['status']}",
          desc: "${response['message']}",
          color: Colors.green,
          icon: Icons.check_circle_outline,
        ),
      );
    } else {
      Get.dialog(
        CustomDialogInformation(
          onTap: () {
            Get.back();
          },
          title: "${response['status']}",
          desc: "${response['message']}",
          color: Colors.orange,
          icon: Icons.error_outline,
        ),
      );
    }
  }

  @override
  onNoInternetConnection() {
    Get.dialog(
      CustomDialogInformation(
        onTap: () {
          Get.back();
        },
        title: "Failed",
        desc: Constants.NO_CONNECTION,
        color: Colors.orange,
        icon: Icons.error_outline,
      ),
    );
  }
}
