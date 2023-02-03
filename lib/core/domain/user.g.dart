// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String,
      typeOfGifts: json['typeOfGifts'],
      numbersOfGifts: json['numbersOfGifts'] as int,
      facebookName: json['facebookName'] as String,
      donateName: json['donateName'] as String,
      receiverName: json['receiverName'] as String,
      receiverAddress: json['receiverAddress'] as String,
      receiverPhoneNumber: json['receiverPhoneNumber'] as String,
      bills: (json['bills'] as List<dynamic>).map((e) => e as String).toList(),
      gifts: json['gifts'] as List<dynamic>,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'typeOfGifts': instance.typeOfGifts,
      'numbersOfGifts': instance.numbersOfGifts,
      'facebookName': instance.facebookName,
      'donateName': instance.donateName,
      'receiverName': instance.receiverName,
      'receiverAddress': instance.receiverAddress,
      'receiverPhoneNumber': instance.receiverPhoneNumber,
      'bills': instance.bills,
      'gifts': instance.gifts,
    };
