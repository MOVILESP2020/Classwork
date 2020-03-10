library company;

import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated and having nested objects.
@JsonSerializable(explicitToJson: true)
class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
