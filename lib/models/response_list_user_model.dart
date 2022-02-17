import '../models/pagination_model.dart';
import '../models/user_model.dart';

// class ResponseListUserModel {
//   ResponseListUserModel({
//     this.status,
//     this.message,
//     this.erorCode,
//     this.results,
//   });

//   int? status;
//   String? message;
//   String? erorCode;
//   Results? results;

//   factory ResponseListUserModel.fromJson(Map<String, dynamic> json) =>
//       ResponseListUserModel(
//         status: json["status"],
//         message: json["message"],
//         erorCode: json["eror_code"],
//         results: Results.fromJson(json["results"]),
//       );
// }

class ResponseListUserModel {
  ResponseListUserModel({
    this.data,
    this.pagination,
  });

  List<UserModel>? data;
  PaginationModel? pagination;

  factory ResponseListUserModel.fromJson(Map<String, dynamic> json) =>
      ResponseListUserModel(
        data: List<UserModel>.from(
          json["data"].map((x) => UserModel.fromJson(x)),
        ),
        pagination: PaginationModel.fromJson(json["pagination"]),
      );
}
