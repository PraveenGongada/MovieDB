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

import 'dart:convert';

import 'package:movie_db/Models/movie_model.dart';

RecommendationsModel recommendationsModelFromJson(String str) =>
    RecommendationsModel.fromJson(json.decode(str));

class RecommendationsModel {
  RecommendationsModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<MovieModel> results;
  int totalPages;
  int totalResults;

  factory RecommendationsModel.fromJson(Map<String, dynamic> json) =>
      RecommendationsModel(
        page: json["page"],
        results: List<MovieModel>.from(
          json["results"].map((x) => MovieModel.fromMap(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
