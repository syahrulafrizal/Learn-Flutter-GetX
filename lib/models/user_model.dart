class UserModel {
  UserModel({
    this.userId,
    this.userFullname,
    this.userShortname,
    this.userMobilephone,
    this.userEmail,
    this.userGender,
    this.userAddress,
    this.userProfession,
    this.userInitial,
  });

  String? userId;
  String? userFullname;
  String? userShortname;
  String? userMobilephone;
  String? userEmail;
  String? userGender;
  String? userAddress;
  String? userProfession;
  String? userInitial;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        userFullname: json["user_fullname"],
        userShortname: json["user_shortname"],
        userMobilephone: json["user_mobilephone"],
        userEmail: json["user_email"],
        userGender: json["user_gender"],
        userAddress: json["user_address"],
        userProfession: json["user_profession"],
        userInitial: json["user_initial"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_fullname": userFullname,
        "user_shortname": userShortname,
        "user_mobilephone": userMobilephone,
        "user_email": userEmail,
        "user_gender": userGender,
        "user_address": userAddress,
        "user_profession": userProfession,
        "user_initial": userInitial,
      };
}
