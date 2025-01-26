import 'package:chatrify/features/contact/domain/entity/contact_entity.dart';

class ContactModel extends ContactEntity {

  ContactModel({
    required id,
    required username,
    required email
  }) : super(
    id: id,
    username: username,
    email: email
  );

  factory ContactModel.fromJson(Map<String, dynamic> json) {
      return ContactModel(
          id: json['contact_id'],
          username: json['username'],
          email: json['email']
      );
  }
}