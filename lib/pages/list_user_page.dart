import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../api/list_user_api_listener.dart';
import '../api/remove_user_api_listener.dart';
import '../api/remove_user_api_services.dart';
import '../models/user_model.dart';
import '../pages/detail_user_page.dart';
import '../api/list_user_api_services.dart';
import '../componets/custom_dialog_information.dart';
import '../componets/custom_dialog_question.dart';
import '../componets/custom_loader.dart';
import '../controllers/list_user_controller.dart';
import '../helper/constants.dart';
import '../helper/my_helper.dart';
import '../helper/screen.dart';
import 'form_user_page.dart';

class ListUserPage extends StatelessWidget implements ListUserApiListener {
  const ListUserPage({Key? key}) : super(key: key);

  onGetListUser(
    String search,
    int page,
    List filter,
    int limit,
    String sort,
  ) {
    printInfo(info: "Call Api");
    ListUserApiServices(this).getListUser(search, filter, page, limit, sort);
  }

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D47A1),
        title: Text(
          "List Data User",
          style: TextStyle(
            fontSize: size.getWidthPx(14),
          ),
        ),
      ),
      body: GetBuilder<ListUserController>(
        init: ListUserController(),
        initState: (_) {
          onGetListUser("", 1, [], 10, "-user_id");
        },
        builder: (c) {
          return (c.isLoading)
              ? const ContentLoading()
              : (c.isError)
                  ? ContentError(onGetListUser: onGetListUser)
                  : ContentSuccess(onGetListUser: onGetListUser);
        },
      ),
      floatingActionButton: GetBuilder<ListUserController>(
        builder: (c) {
          return Visibility(
            visible: !c.isLoading,
            child: FloatingActionButton(
              onPressed: () async {
                dynamic result = await Get.to(
                  () => const FormUserPage(data: null),
                );
                if (result != null) {
                  c.onRefresh();
                  onGetListUser("", 1, [], 10, "-user_id");
                }
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
              backgroundColor: const Color(0xFF0D47A1),
            ),
          );
        },
      ),
    );
  }

  @override
  onListUserFailure(response, statusCode) {
    final myC = Get.find<ListUserController>();
    myC.onListUserFailure(response, statusCode);
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
  onListUserSuccess(response, statusCode) {
    final myC = Get.find<ListUserController>();
    myC.onListUserSuccess(response, statusCode);
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
    final myC = Get.find<ListUserController>();
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
            child: Row(
              children: [
                Container(
                  width: size.getWidthPx(45),
                  height: size.getWidthPx(45),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: size.getWidthPx(14),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(
                        height: 8,
                      ),
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
                    ],
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
  final dynamic onGetListUser;

  const ContentError({
    Key? key,
    required this.onGetListUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return GetBuilder<ListUserController>(
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
                onGetListUser("", 1, [], 10, "-user_id");
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
  final dynamic onGetListUser;
  const ContentSuccess({
    Key? key,
    required this.onGetListUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListUserController>(
      builder: (c) {
        return (c.responseList.isNotEmpty)
            ? ListData(onGetListUser: onGetListUser)
            : DataEmpty(onGetListUser: onGetListUser);
      },
    );
  }
}

class DataEmpty extends StatelessWidget {
  final dynamic onGetListUser;
  const DataEmpty({
    Key? key,
    required this.onGetListUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return GetBuilder<ListUserController>(
      builder: (c) {
        return SmartRefresher(
          controller: c.refreshController,
          onRefresh: () {
            c.onRefresh();
            onGetListUser("", 1, [], 10, "-user_id");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Constants.NOT_FOUND_IMAGE,
                width: size.getWidthPx(150),
                height: size.getWidthPx(150),
                fit: BoxFit.fill,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                child: Center(
                  child: Text(
                    Constants.NODATA,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: size.getWidthPx(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ListData extends StatelessWidget {
  final dynamic onGetListUser;
  const ListData({
    Key? key,
    required this.onGetListUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListUserController>(
      builder: (c) {
        return SmartRefresher(
          controller: c.refreshController,
          onRefresh: () {
            c.onRefresh();
            onGetListUser("", 1, [], 10, "-user_id");
          },
          onLoading: () {
            onGetListUser("", c.nextPage, [], 10, "-user_id");
          },
          enablePullUp: c.nextPage != 0 ? true : false,
          child: ListView.separated(
            padding: const EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              UserModel item = c.responseList[index];
              return ItemData(
                item: item,
                index: index,
                onGetListUser: onGetListUser,
              );
            },
            itemCount: c.responseList.length,
            separatorBuilder: (BuildContext context, int index) {
              return MyHelpers.renderDivider();
            },
          ),
        );
      },
    );
  }
}

class ItemData extends StatelessWidget implements RemoveUserApiListener {
  final UserModel item;
  final int index;
  final dynamic onGetListUser;

  const ItemData({
    Key? key,
    required this.item,
    required this.index,
    required this.onGetListUser,
  }) : super(key: key);

  onDeleteUser() {
    Get.dialog(
      CustomDialogQuestion(
        title: "",
        onTapOke: () async {
          Get.back();
          Get.dialog(const CustomLoader());
          RemoveUserApiServices(this).postRemoveUser(item.userId.toString());
        },
        desc: "Apakahan Anda yakin ingin menghapus data user ?",
      ),
    );
  }

  onItemClicked(Screen size) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: <Widget>[
            ItemOptionUser(
              item: item,
              title: 'Detail Data User',
              action: () {
                Get.to(() => DetailUserPage(user: item));
              },
              icon: Icons.remove_red_eye,
            ),
            ItemOptionUser(
              item: item,
              title: 'Ubah Data User',
              action: () async {
                dynamic result = await Get.to(
                  () => FormUserPage(data: item),
                );
                printInfo(info: item.userFullname.toString());
                if (result != null) {
                  final c = Get.find<ListUserController>();
                  c.onRefresh();
                  onGetListUser("", 1, [], 10, "-user_id");
                }
              },
              icon: Icons.edit,
            ),
            ItemOptionUser(
              item: item,
              title: 'Hapus Data User',
              action: onDeleteUser,
              icon: Icons.delete,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Screen size = Screen(MediaQuery.of(context).size);
    return InkWell(
      onTap: () {
        onItemClicked(size);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: size.getWidthPx(12),
              bottom: size.getWidthPx(12),
              left: size.getWidthPx(16),
              right: size.getWidthPx(16),
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Container(
                    width: size.getWidthPx(45),
                    height: size.getWidthPx(45),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                      color: Colors.purple,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${item.userInitial}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: size.getWidthPx(16),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.getWidthPx(14),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.userFullname ?? 'n/a',
                        style: TextStyle(
                          fontSize: size.getWidthPx(16),
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        item.userMobilephone ?? '-',
                        style: TextStyle(
                          fontSize: size.getWidthPx(12),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  @override
  onRemoveUserFailure(response, statusCode) {
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
  onRemoveUserSuccess(response, statusCode) {
    Get.back();
    if (response['status'] == 200) {
      final myC = Get.find<ListUserController>();
      myC.onRefresh();
      onGetListUser("", 1, [], 10, "-user_id");
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
}

class ItemOptionUser extends StatelessWidget {
  final UserModel item;
  final String title;
  final dynamic action;
  final IconData icon;

  const ItemOptionUser({
    Key? key,
    required this.item,
    required this.title,
    this.action,
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
