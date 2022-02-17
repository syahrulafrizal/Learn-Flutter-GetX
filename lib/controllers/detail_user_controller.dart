import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../helper/constants.dart';
import '../models/response_detail_user_model.dart';

class DetailUserController extends GetxController {
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );
  bool isLoading = true;
  bool isError = false;
  String errorMsg = Constants.ERROR_SERVER;
  String errorImg = Constants.ERROR_IMAGE;
  ResponseDetailUserModel dataRes = ResponseDetailUserModel();

  onRefresh() {
    isLoading = true;
    isError = false;
    update();
  }

  onDetailUserSuccess(response, statusCode) {
    if (response['status'] == 200) {
      dataRes = ResponseDetailUserModel.fromJson(response['results']);
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

  onDetailUserFailure(response, statusCode) {
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
