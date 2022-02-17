import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/api/detail_user_api_listener.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../api/detail_user_api_services.dart';
import '../componets/custom_dialog_information.dart';
import '../controllers/detail_user_controller.dart';
import '../helper/my_helper.dart';
import '../models/user_model.dart';

import '../helper/screen.dart';

class DetailUserPage extends StatelessWidget implements DetailUserApiListener {
  final UserModel user;
  const DetailUserPage({Key? key, required this.user}) : super(key: key);

  onGetDetailUser() {
    printInfo(info: "Call Api");
    DetailUserApiServices(this).getDetailUser(user.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: Text(
          "Detail Data User",
          style: TextStyle(
            fontSize: size.getWidthPx(14),
          ),
        ),
      ),
      body: GetBuilder<DetailUserController>(
        init: DetailUserController(),
        initState: (_) {
          onGetDetailUser();
        },
        builder: (c) {
          return (c.isLoading)
              ? const ContentLoading()
              : (c.isError)
                  ? ContentError(onGetDetailUser: onGetDetailUser)
                  : ContentSuccess(onGetDetailUser: onGetDetailUser);
        },
      ),
    );
  }

  @override
  onDetailUserFailure(response, statusCode) {
    final myC = Get.find<DetailUserController>();
    myC.onDetailUserFailure(response, statusCode);
    Get.dialog(
      CustomDialogInformation(
        onTap: () {
          Get.back();
        },
        title: "${response['status']}",
        desc: myC.errorMsg,
        color: Colors.red,
        icon: Icons.error_outline,
      ),
    );
  }

  @override
  onDetailUserSuccess(response, statusCode) {
    final myC = Get.find<DetailUserController>();
    myC.onDetailUserSuccess(response, statusCode);
    if (response['status'] != 200) {
      Get.dialog(
        CustomDialogInformation(
          onTap: () {
            Get.back();
          },
          title: "${response['status']}",
          desc: myC.errorMsg,
          color: Colors.orange,
          icon: Icons.error_outline,
        ),
      );
    }
  }

  @override
  onNoInternetConnection() {
    final myC = Get.find<DetailUserController>();
    myC.onNoInternetConnection();
    Get.dialog(
      CustomDialogInformation(
        onTap: () {
          Get.back();
        },
        title: "Failed",
        desc: myC.errorMsg,
        color: Colors.orange,
        icon: Icons.error_outline,
      ),
    );
  }
}

class ContentLoading extends StatelessWidget {
  const ContentLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemBuilder: (BuildContext context, int index) {
        return const ItemLoading();
      },
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) {
        return MyHelpers.renderDivider();
      },
    );
  }
}

class ItemLoading extends StatelessWidget {
  const ItemLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Shimmer.fromColors(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: size.getWidthPx(16),
              bottom: size.getWidthPx(16),
              left: size.getWidthPx(16),
              right: size.getWidthPx(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.getWidthPx(10),
                  width: size.wp(50),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: size.getWidthPx(10),
                  width: size.wp(70),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
    );
  }
}

class ContentError extends StatelessWidget {
  final dynamic onGetDetailUser;

  const ContentError({
    Key? key,
    required this.onGetDetailUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return GetBuilder<DetailUserController>(
      builder: (c) {
        return Column(
          key: const ValueKey("content-error"),
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              c.errorImg,
              width: size.getWidthPx(150),
              height: size.getWidthPx(150),
              fit: BoxFit.fill,
              key: const ValueKey("activity-error-state"),
            ),
            Container(
              key: const ValueKey("message-error"),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Center(
                child: Text(
                  c.errorMsg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: size.getWidthPx(14),
                  ),
                ),
              ),
            ),
            InkWell(
              key: const ValueKey("activity-refresh-button"),
              onTap: () {
                c.onRefresh();
                onGetDetailUser("", 1, [], 10, "-user_id");
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: size.getWidthPx(64)),
                padding: EdgeInsets.symmetric(
                  vertical: size.getWidthPx(12),
                  horizontal: size.getWidthPx(14),
                ),
                child: Text(
                  "Coba Lagi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size.getWidthPx(14),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ContentSuccess extends StatelessWidget {
  final dynamic onGetDetailUser;
  const ContentSuccess({Key? key, required this.onGetDetailUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailUserController>(
      builder: (c) {
        UserModel user = c.dataRes.data!;
        return SmartRefresher(
          controller: c.refreshController,
          onRefresh: () {
            c.onRefresh();
            onGetDetailUser();
          },
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              ItemDetailUser(
                label: 'Nama Lengkap :',
                value: '${user.userFullname}',
              ),
              MyHelpers.renderDivider(),
              ItemDetailUser(
                label: 'Nama Panggilan :',
                value: '${user.userShortname}',
              ),
              MyHelpers.renderDivider(),
              ItemDetailUser(
                label: 'Nomor Handphone :',
                value: '${user.userMobilephone}',
              ),
              MyHelpers.renderDivider(),
              ItemDetailUser(
                label: 'Email :',
                value: '${user.userEmail}',
              ),
              MyHelpers.renderDivider(),
              ItemDetailUser(
                label: 'Jenis Kelamin :',
                value: '${user.userGender}',
              ),
              MyHelpers.renderDivider(),
              ItemDetailUser(
                label: 'Alamat :',
                value: '${user.userAddress}',
              ),
              MyHelpers.renderDivider(),
              ItemDetailUser(
                label: 'Pekerjaan :',
                value: '${user.userProfession}',
              ),
              MyHelpers.renderDivider(),
            ],
          ),
        );
      },
    );
  }
}

class ItemDetailUser extends StatelessWidget {
  const ItemDetailUser({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Container(
      margin: EdgeInsets.only(
        top: size.getWidthPx(16),
        bottom: size.getWidthPx(16),
        left: size.getWidthPx(16),
        right: size.getWidthPx(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: size.getWidthPx(12),
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: size.getWidthPx(15),
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
