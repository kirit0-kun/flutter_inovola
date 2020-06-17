import 'package:equatable/equatable.dart';

class Trip extends Equatable {
  final int id;
  final String title;
  final List<String> images;
  final String interest;
  final int price;
  final DateTime date;
  final String address;
  final Trainer trainer;
  final String occasionDetail;
  final String latitude;
  final String longitude;
  final bool isLiked;
  final bool isSold;
  final bool isPrivateEvent;
  final bool hiddenCashPayment;
  final int specialForm;
  final String questionnaire;
  final String questExplanation;
  final List<ReserveType> reservTypes;

  Trip(
      this.id,
      this.title,
      this.images,
      this.interest,
      this.price,
      this.date,
      this.address,
      this.trainer,
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
      this.reservTypes);

  @override
  List<Object> get props => [id, isLiked, date, title, isSold, isPrivateEvent];

  Trip setLiked(bool liked) {
    return Trip(
        this.id,
        this.title,
        this.images,
        this.interest,
        this.price,
        this.date,
        this.address,
        this.trainer,
        this.occasionDetail,
        this.latitude,
        this.longitude,
        liked,
        this.isSold,
        this.isPrivateEvent,
        this.hiddenCashPayment,
        this.specialForm,
        this.questionnaire,
        this.questExplanation,
        this.reservTypes);
  }
}

class ReserveType {
  final int id;
  final String name;
  final int count;
  final int price;

  ReserveType(this.id, this.name, this.count, this.price);
}

class Trainer {
  final String name;
  final String image;
  final String info;

  Trainer(this.name, this.image, this.info);
}
