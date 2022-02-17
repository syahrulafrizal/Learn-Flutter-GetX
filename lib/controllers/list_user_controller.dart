import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../models/response_list_user_model.dart';

import '../helper/constants.dart';
import '../models/user_model.dart';

class ListUserController extends GetxController {
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );
  bool isLoading = true;
  bool isError = false;
  String errorMsg = Constants.ERROR_SERVER;
  String errorImg = Constants.ERROR_IMAGE;
  List<UserModel> responseList = [];
  List filter = [];
  int nextPage = 0, limit = 10;
  String search = "";
  ResponseListUserModel dataRes = ResponseListUserModel();

  onRefresh() {
    isLoading = true;
    responseList.clear();
    nextPage = 1;
    isError = false;
    update();
  }

  onListUserSuccess(response, statusCode) {
    if (response['status'] == 200) {
      dataRes = ResponseListUserModel.fromJson(response['results']);
      responseList.addAll(dataRes.data!);
      nextPage = dataRes.pagination!.next!;
      isError = false;
      isLoading = false;
    } else {
      isError = true;
      isLoading = false;
      errorMsg = response['message'] ?? Constants.ERROR_SERVER;
      errorImg = Constants.ERROR_IMAGE;
    }
    refreshController.refreshCompleted();
    refreshController.loadComplete();
    update();
  }

  onListUserFailure(response, statusCode) {
    isLoading = false;
    isError = true;
    errorMsg = response['message'] ?? Constants.ERROR_SERVER;
    errorImg = Constants.ERROR_IMAGE;
    refreshController.refreshCompleted();
    refreshController.loadComplete();
    update();
  }

  onNoInternetConnection() {
    isLoading = false;
    isError = true;
    errorMsg = Constants.NO_CONNECTION;
    errorImg = Constants.NOT_CONNECTION_IMAGE;
    refreshController.refreshCompleted();
    refreshController.loadComplete();
    update();
  }
}
