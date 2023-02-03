import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel({
    required String uid,
    required dynamic typeOfGifts,
    required int numbersOfGifts,
    required String facebookName,
    required String donateName,
    required String receiverName,
    required String receiverAddress,
    required String receiverPhoneNumber,
    required List<String> bills,
    required List<dynamic> gifts,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
