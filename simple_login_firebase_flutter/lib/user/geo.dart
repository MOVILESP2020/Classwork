library geo;

import 'package:json_annotation/json_annotation.dart';

part 'geo.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated and having nested objects.
@JsonSerializable(explicitToJson: true)
class Geo {
  String lat;
  String lng;

  Geo({
    this.lat,
    this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);
}
