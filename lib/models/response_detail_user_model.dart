import '../models/user_model.dart';

class ResponseDetailUserModel {
  ResponseDetailUserModel({
    this.data,
  });

  UserModel? data;

  factory ResponseDetailUserModel.fromJson(Map<String, dynamic> json) =>
      ResponseDetailUserModel(
        data: UserModel.fromJson(json["data"]),
      );
}
