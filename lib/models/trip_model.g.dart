// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripResponseModel _$TripResponseModelFromJson(Map<String, dynamic> json) {
  return TripResponseModel(
    json['id'] as int,
    json['title'] as String,
    (json['img'] as List)?.map((e) => e as String)?.toList(),
    json['interest'] as String,
    json['price'] as int,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['address'] as String,
    json['trainerName'] as String,
    json['trainerImg'] as String,
    json['trainerInfo'] as String,
    json['occasionDetail'] as String,
    json['latitude'] as String,
    json['longitude'] as String,
    json['isLiked'] as bool,
    json['isSold'] as bool,
    json['isPrivateEvent'] as bool,
    json['hiddenCashPayment'] as bool,
    json['specialForm'] as int,
    json['questionnaire'] as String,
    json['questExplanation'] as String,
    (json['reservTypes'] as List)
        ?.map((e) => e == null
            ? null
            : ReservTypeModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TripResponseModelToJson(TripResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'img': instance.images,
      'interest': instance.interest,
      'price': instance.price,
      'date': instance.date?.toIso8601String(),
      'address': instance.address,
      'trainerName': instance.trainerName,
      'trainerImg': instance.trainerImg,
      'trainerInfo': instance.trainerInfo,
      'occasionDetail': instance.occasionDetail,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isLiked': instance.isLiked,
      'isSold': instance.isSold,
      'isPrivateEvent': instance.isPrivateEvent,
      'hiddenCashPayment': instance.hiddenCashPayment,
      'specialForm': instance.specialForm,
      'questionnaire': instance.questionnaire,
      'questExplanation': instance.questExplanation,
      'reservTypes': instance.reservTypes,
    };

ReservTypeModel _$ReservTypeModelFromJson(Map<String, dynamic> json) {
  return ReservTypeModel(
    json['id'] as int,
    json['name'] as String,
    json['count'] as int,
    json['price'] as int,
  );
}

Map<String, dynamic> _$ReservTypeModelToJson(ReservTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
      'price': instance.price,
    };
