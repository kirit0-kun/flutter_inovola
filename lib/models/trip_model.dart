import 'package:flutterinovola/entities/trip.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trip_model.g.dart';

@JsonSerializable()
class TripResponseModel extends Trip {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'img')
  final List<String> images;
  @JsonKey(name: 'interest')
  final String interest;
  @JsonKey(name: 'price')
  final int price;
  @JsonKey(name: 'date')
  final DateTime date;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'trainerName')
  final String trainerName;
  @JsonKey(name: 'trainerImg')
  final String trainerImg;
  @JsonKey(name: 'trainerInfo')
  final String trainerInfo;
  @JsonKey(name: 'occasionDetail')
  final String occasionDetail;
  @JsonKey(name: 'latitude')
  final String latitude;
  @JsonKey(name: 'longitude')
  final String longitude;
  @JsonKey(name: 'isLiked')
  final bool isLiked;
  @JsonKey(name: 'isSold')
  final bool isSold;
  @JsonKey(name: 'isPrivateEvent')
  final bool isPrivateEvent;
  @JsonKey(name: 'hiddenCashPayment')
  final bool hiddenCashPayment;
  @JsonKey(name: 'specialForm')
  final int specialForm;
  @JsonKey(name: 'questionnaire')
  final String questionnaire;
  @JsonKey(name: 'questExplanation')
  final String questExplanation;
  @JsonKey(name: 'reservTypes')
  final List<ReservTypeModel> reservTypes;

  TripResponseModel(
      this.id,
      this.title,
      this.images,
      this.interest,
      this.price,
      this.date,
      this.address,
      this.trainerName,
      this.trainerImg,
      this.trainerInfo,
      this.occasionDetail,
      this.latitude,
      this.longitude,
      this.isLiked,
      this.isSold,
      this.isPrivateEvent,
      this.hiddenCashPayment,
      this.specialForm,
      this.questionnaire,
      this.questExplanation,
      this.reservTypes)
      : super(
            id,
            title?.trim(),
            images,
            interest?.trim(),
            price,
            date,
            address?.trim(),
            Trainer(
              trainerName?.trim(),
              trainerImg,
              trainerInfo?.trim(),
            ),
            occasionDetail?.trim(),
            latitude,
            longitude,
            isLiked,
            isSold,
            isPrivateEvent,
            hiddenCashPayment,
            specialForm,
            questionnaire,
            questExplanation,
            reservTypes);

  factory TripResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TripResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$TripResponseModelToJson(this);
}

@JsonSerializable(nullable: false)
class ReservTypeModel extends ReserveType {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'count')
  final int count;
  @JsonKey(name: 'price')
  final int price;

  ReservTypeModel(this.id, this.name, this.count, this.price)
      : super(id, name, count, price);

  factory ReservTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ReservTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReservTypeModelToJson(this);
}
