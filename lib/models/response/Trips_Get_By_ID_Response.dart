// To parse this JSON data, do
//
//     final tripsGetByIdResponse = tripsGetByIdResponseFromJson(jsonString);

import 'dart:convert';

TripsGetByIdResponse tripsGetByIdResponseFromJson(String str) => TripsGetByIdResponse.fromJson(json.decode(str));

String tripsGetByIdResponseToJson(TripsGetByIdResponse data) => json.encode(data.toJson());

class TripsGetByIdResponse {
    int idx;
    String name;
    String country;
    String coverimage;
    String detail;
    int price;
    int duration;
    String destinationZone;

    TripsGetByIdResponse({
        required this.idx,
        required this.name,
        required this.country,
        required this.coverimage,
        required this.detail,
        required this.price,
        required this.duration,
        required this.destinationZone,
    });

    factory TripsGetByIdResponse.fromJson(Map<String, dynamic> json) => TripsGetByIdResponse(
        idx: json["idx"],
        name: json["name"],
        country: json["country"],
        coverimage: json["coverimage"],
        detail: json["detail"],
        price: json["price"],
        duration: json["duration"],
        destinationZone: json["destination_zone"],
    );

    Map<String, dynamic> toJson() => {
        "idx": idx,
        "name": name,
        "country": country,
        "coverimage": coverimage,
        "detail": detail,
        "price": price,
        "duration": duration,
        "destination_zone": destinationZone,
    };
}
