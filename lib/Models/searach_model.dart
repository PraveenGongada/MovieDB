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

import 'movie_model.dart';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

class SearchModel {
  final int? page;
  final List<MovieModel>? results;
  final int? totalPages;
  final int? totalResults;

  SearchModel({this.page, this.results, this.totalPages, this.totalResults});

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    page: json["page"],
    results:
        json["results"] == null
            ? []
            : List<MovieModel>.from(
              json["results"]!.map((x) => MovieModel.fromMap(x)),
            ),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );
}
