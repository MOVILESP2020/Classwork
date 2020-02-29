library address;

import 'package:json_annotation/json_annotation.dart';
import 'package:login_bloc/user/geo.dart';

part 'address.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated and having nested objects.
@JsonSerializable(explicitToJson: true)
class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
