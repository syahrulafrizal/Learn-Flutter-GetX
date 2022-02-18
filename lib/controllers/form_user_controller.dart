import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/models/user_model.dart';

import '../helper/my_helper.dart';

class FormUserController extends GetxController {
  TextEditingController inputFullName = TextEditingController();
  bool validateFullName = true;
  String msgFullName = "";

  TextEditingController inputShortName = TextEditingController();
  bool validateShortName = true;
  String msgShortName = "";

  TextEditingController inputPhonenumber = TextEditingController();
  bool validatePhonenumber = true;
  String msgPhonenumber = "";

  TextEditingController inputEmail = TextEditingController();
  bool validateEmail = true;
  String msgEmail = "";

  TextEditingController inputGender = TextEditingController();
  bool validateGender = true;
  String msgGender = "";

  TextEditingController inputAddress = TextEditingController();
  bool validateAddress = true;
  String msgAddress = "";

  TextEditingController inputJob = TextEditingController();
  bool validateJob = true;
  String msgJob = "";

  UserModel? dataUser;

  onSetDataUser(UserModel data) {
    printInfo(info: data.userFullname.toString());
    dataUser = UserModel(
      userAddress: data.userAddress,
      userEmail: data.userEmail,
      userFullname: data.userFullname,
      userGender: data.userGender,
      userId: data.userId,
      userInitial: data.userInitial,
      userMobilephone: data.userMobilephone,
      userProfession: data.userProfession,
      userShortname: data.userShortname,
    );
    inputFullName.value = TextEditingValue(
      text: dataUser!.userFullname.toString(),
      selection: TextSelection.collapsed(
        offset: dataUser!.userFullname.toString().length,
      ),
    );
    inputShortName.value = TextEditingValue(
      text: dataUser!.userShortname.toString(),
      selection: TextSelection.collapsed(
        offset: dataUser!.userShortname.toString().length,
      ),
    );
    inputPhonenumber.value = TextEditingValue(
      text: dataUser!.userMobilephone.toString(),
      selection: TextSelection.collapsed(
        offset: dataUser!.userMobilephone.toString().length,
      ),
    );
    inputEmail.value = TextEditingValue(
      text: dataUser!.userEmail.toString(),
      selection: TextSelection.collapsed(
        offset: dataUser!.userEmail.toString().length,
      ),
    );
    inputGender.value = TextEditingValue(
      text: dataUser!.userGender.toString(),
      selection: TextSelection.collapsed(
        offset: dataUser!.userGender.toString().length,
      ),
    );
    inputAddress.value = TextEditingValue(
      text: dataUser!.userAddress.toString(),
      selection: TextSelection.collapsed(
        offset: dataUser!.userAddress.toString().length,
      ),
    );
    inputJob.value = TextEditingValue(
      text: dataUser!.userProfession.toString(),
      selection: TextSelection.collapsed(
        offset: dataUser!.userProfession.toString().length,
      ),
    );
    update();
  }

  onSelectGender(value) {
    inputGender.value = TextEditingValue(text: value);
    update();
  }

  onValidationFormInput() {
    String valueFullName = inputFullName.text.toString().trim();
    String valueShortName = inputShortName.text.toString().trim();
    String valuePhonenumber = inputPhonenumber.text.toString().trim();
    String valueEmail = inputEmail.text.toString().trim();
    String valueGender = inputGender.text.toString().trim();
    String valueAddress = inputAddress.text.toString().trim();
    String valueJob = inputJob.text.toString().trim();

    if (valueFullName.isEmpty) {
      validateFullName = false;
      msgFullName = "Nama lengkap tidak boleh kosong";
    } else {
      validateFullName = true;
      msgFullName = "";
    }

    if (valueShortName.isEmpty) {
      validateShortName = false;
      msgShortName = "Nama panggilan tidak boleh kosong";
    } else {
      validateShortName = true;
      msgShortName = "";
    }

    if (valuePhonenumber.isEmpty) {
      validatePhonenumber = false;
      msgPhonenumber = "Nomor handphone tidak boleh kosong";
    } else {
      validatePhonenumber = true;
      msgPhonenumber = "";
    }

    if (valueEmail.isEmpty) {
      validateEmail = false;
      msgEmail = "Email tidak boleh kosong";
    } else {
      if (!MyHelpers.validateEmail(valueEmail)) {
        validateEmail = false;
        msgEmail = "Email tidak valid";
      } else {
        validateEmail = true;
        msgEmail = "";
      }
    }

    if (valueGender.isEmpty) {
      validateGender = false;
      msgGender = "Jenis Kelamin tidak boleh kosong";
    } else {
      validateGender = true;
      msgGender = "";
    }

    if (valueAddress.isEmpty) {
      validateAddress = false;
      msgAddress = "Alamat tidak boleh kosong";
    } else {
      validateAddress = true;
      msgAddress = "";
    }

    if (valueJob.isEmpty) {
      validateJob = false;
      msgJob = "Pekerjaan tidak boleh kosong";
    } else {
      validateJob = true;
      msgJob = "";
    }

    update();

    if (validateFullName &&
        validateShortName &&
        validatePhonenumber &&
        validateEmail &&
        validateGender &&
        validateAddress &&
        validateJob) {
      return true;
    }

    return false;
  }
}
