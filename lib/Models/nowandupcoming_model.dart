/*
 * Copyright 2025 Praveen Kumar
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// To parse this JSON data, do

import 'dart:convert';

import 'package:movie_db/Models/movie_model.dart';

NowandUpcomingModel nowandupcomingFromJson(String str) =>
    NowandUpcomingModel.fromJson(json.decode(str));

class NowandUpcomingModel {
  NowandUpcomingModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Dates dates;
  int? page;
  List<MovieModel> results;
  int? totalPages;
  int? totalResults;

  factory NowandUpcomingModel.fromJson(Map<String, dynamic> json) =>
      NowandUpcomingModel(
        dates: Dates.fromJson(json["dates"]),
        page: json["page"],
        results: List<MovieModel>.from(
          json["results"].map((x) => MovieModel.fromMap(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Dates {
  Dates({required this.maximum, required this.minimum});

  DateTime? maximum;
  DateTime? minimum;

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
    maximum: DateTime.parse(json["maximum"]),
    minimum: DateTime.parse(json["minimum"]),
  );

  Map<String, dynamic> toJson() => {
    "maximum":
        "${maximum?.year.toString().padLeft(4, '0')}-${maximum?.month.toString().padLeft(2, '0')}-${maximum?.day.toString().padLeft(2, '0')}",
    "minimum":
        "${minimum?.year.toString().padLeft(4, '0')}-${minimum?.month.toString().padLeft(2, '0')}-${minimum?.day.toString().padLeft(2, '0')}",
  };
}
