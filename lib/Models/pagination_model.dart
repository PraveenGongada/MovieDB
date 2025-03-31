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

import 'package:flutter/foundation.dart';
import 'package:movie_db/Models/movie_model.dart';

class PaginationModel {
  List<MovieModel> results;
  int pageno;
  String query;
  bool isLoading;
  bool isFetchingNext;
  String error;
  bool hasNext;
  String cursor;
  int limit;
  PaginationModel({
    this.results = const [],
    this.pageno = 1,
    this.query = '',
    this.isLoading = false,
    this.isFetchingNext = false,
    this.error = '',
    this.hasNext = true,
    this.cursor = '',
    this.limit = 10,
  });

  PaginationModel copyWith({
    List<MovieModel>? results,
    int? pageno,
    String? query,
    bool? isLoading,
    bool? isFetchingNext,
    String? error,
    bool? hasNext,
  }) {
    return PaginationModel(
      results: results ?? this.results,
      pageno: pageno ?? this.pageno,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      isFetchingNext: isFetchingNext ?? this.isFetchingNext,
      error: error ?? this.error,
      hasNext: hasNext ?? this.hasNext,
    );
  }

  @override
  String toString() {
    return 'SearchNotifierModel(results: $results, pageno: $pageno, query: $query ,isLoading: $isLoading, isFetchingNext: $isFetchingNext, error: $error, hasNext: $hasNext)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaginationModel &&
        listEquals(other.results, results) &&
        other.pageno == pageno &&
        other.query == query &&
        other.isLoading == isLoading &&
        other.isFetchingNext == isFetchingNext &&
        other.error == error &&
        other.hasNext == hasNext;
  }

  @override
  int get hashCode {
    return results.hashCode ^
        pageno.hashCode ^
        query.hashCode ^
        isLoading.hashCode ^
        isFetchingNext.hashCode ^
        error.hashCode ^
        hasNext.hashCode;
  }
}
