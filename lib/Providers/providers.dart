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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_db/Models/cast_model.dart';
import 'package:movie_db/Models/recommendations_model.dart';
import 'package:movie_db/Models/reviews_model.dart';
import 'package:movie_db/Models/similar_model.dart';
import 'package:movie_db/Models/videos_model.dart';
import 'package:movie_db/Services/themovie_db.dart';
import 'package:movie_db/Models/pagination_model.dart';

abstract class Providers {
  static final nowplayingprovider = FutureProvider(
    (ref) => TheMovieDB.getnowplaying(),
  );

  static final popularprovider =
      StateNotifierProvider.autoDispose<PopularNotifier, PaginationModel>(
        (ref) => PopularNotifier(),
      );

  static final upcomingprovider =
      StateNotifierProvider.autoDispose<UpcomingNotifier, PaginationModel>(
        (ref) => UpcomingNotifier(),
      );

  static final topratedprovider =
      StateNotifierProvider.autoDispose<TopratedNotifier, PaginationModel>(
        (ref) => TopratedNotifier(),
      );

  static final getsimilarprovider = FutureProvider.family<SimilarModel, int>(
    (ref, id) => TheMovieDB.getsimilar(id),
  );

  static final getrecommendationsprovider =
      FutureProvider.family<RecommendationsModel, int>(
        (ref, id) => TheMovieDB.getrecommendations(id),
      );

  static final getvideosprovider = FutureProvider.family<VideosModel, int>(
    (ref, id) => TheMovieDB.getvideos(id),
  );

  static final getcastprovider = FutureProvider.family<CastModel, int>(
    (ref, id) => TheMovieDB.getcast(id),
  );

  static final getreviewsprovider = FutureProvider.family<ReviewsModel, int>(
    (ref, id) => TheMovieDB.getreviews(id),
  );

  static final searchprovider =
      StateNotifierProvider.autoDispose<SearchNotifier, PaginationModel>(
        (ref) => SearchNotifier(),
      );
}

class SearchNotifier extends StateNotifier<PaginationModel> {
  SearchNotifier() : super(PaginationModel());

  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Future<void> getData(String query) async {
    state = state.copyWith(isLoading: true, query: query, pageno: 1);
    try {
      final data = await TheMovieDB.getSearchResults(query, state.pageno);
      if (data.results != null && data.results!.isNotEmpty) {
        if (data.results!.length < 20) {
          state = state.copyWith(
            results: data.results,
            isLoading: false,
            hasNext: false,
          );
        } else {
          state = state.copyWith(results: data.results, isLoading: false);
        }
      } else {
        state = state.copyWith(results: [], isLoading: false);
      }
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> fetchMore() async {
    final oldState = [...state.results];
    state = state.copyWith(isFetchingNext: true, pageno: ++state.pageno);
    try {
      final data = await TheMovieDB.getSearchResults(state.query, state.pageno);
      if (data.results != null && data.results!.isNotEmpty) {
        if (data.results!.length < 20) {
          state = state.copyWith(
            results: [...oldState, ...data.results!],
            isFetchingNext: false,
            hasNext: false,
          );
        } else {
          state = state.copyWith(
            results: [...oldState, ...data.results!],
            isFetchingNext: false,
          );
        }
      } else {
        state = state.copyWith(results: [...oldState], isFetchingNext: false);
      }
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString(), isFetchingNext: false);
    }
  }

  void clearSearch() {
    state = PaginationModel();
    textEditingController.clear();
  }

  @override
  void dispose() {
    focusNode.dispose();
    textEditingController.dispose();
    super.dispose();
  }
}

class PopularNotifier extends StateNotifier<PaginationModel> {
  PopularNotifier() : super(PaginationModel()) {
    getData();
  }

  Future<void> getData() async {
    state = state.copyWith(isLoading: true, pageno: 1);
    try {
      final data = await TheMovieDB.getpopular(state.pageno);
      if (data.results.isNotEmpty) {
        if (data.results.length < 20) {
          state = state.copyWith(
            results: data.results,
            isLoading: false,
            hasNext: false,
          );
        } else {
          state = state.copyWith(results: data.results, isLoading: false);
        }
      } else {
        state = state.copyWith(results: [], isLoading: false);
      }
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> fetchMore() async {
    final oldState = [...state.results];
    state = state.copyWith(isFetchingNext: true, pageno: ++state.pageno);
    try {
      final data = await TheMovieDB.getpopular(state.pageno);
      if (data.results.isNotEmpty) {
        if (data.results.length < 20) {
          state = state.copyWith(
            results: [...oldState, ...data.results],
            isFetchingNext: false,
            hasNext: false,
          );
        } else {
          state = state.copyWith(
            results: [...oldState, ...data.results],
            isFetchingNext: false,
          );
        }
      } else {
        state = state.copyWith(results: [...oldState], isFetchingNext: false);
      }
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString(), isFetchingNext: false);
    }
  }
}

class UpcomingNotifier extends StateNotifier<PaginationModel> {
  UpcomingNotifier() : super(PaginationModel()) {
    getData();
  }

  Future<void> getData() async {
    state = state.copyWith(isLoading: true, pageno: 1);
    try {
      final data = await TheMovieDB.getupcoming(state.pageno);
      if (data.results.isNotEmpty) {
        if (data.results.length < 20) {
          state = state.copyWith(
            results: data.results,
            isLoading: false,
            hasNext: false,
          );
        } else {
          state = state.copyWith(results: data.results, isLoading: false);
        }
      } else {
        state = state.copyWith(results: [], isLoading: false);
      }
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> fetchMore() async {
    final oldState = [...state.results];
    state = state.copyWith(isFetchingNext: true, pageno: ++state.pageno);
    try {
      final data = await TheMovieDB.getupcoming(state.pageno);
      if (data.results.isNotEmpty) {
        if (data.results.length < 20) {
          state = state.copyWith(
            results: [...oldState, ...data.results],
            isFetchingNext: false,
            hasNext: false,
          );
        } else {
          state = state.copyWith(
            results: [...oldState, ...data.results],
            isFetchingNext: false,
          );
        }
      } else {
        state = state.copyWith(results: [...oldState], isFetchingNext: false);
      }
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString(), isFetchingNext: false);
    }
  }
}

class TopratedNotifier extends StateNotifier<PaginationModel> {
  TopratedNotifier() : super(PaginationModel()) {
    getData();
  }

  Future<void> getData() async {
    state = state.copyWith(isLoading: true, pageno: 1);
    try {
      final data = await TheMovieDB.getToprated(state.pageno);
      if (data.results.isNotEmpty) {
        if (data.results.length < 20) {
          state = state.copyWith(
            results: data.results,
            isLoading: false,
            hasNext: false,
          );
        } else {
          state = state.copyWith(results: data.results, isLoading: false);
        }
      } else {
        state = state.copyWith(results: [], isLoading: false);
      }
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> fetchMore() async {
    final oldState = [...state.results];
    state = state.copyWith(isFetchingNext: true, pageno: ++state.pageno);
    try {
      final data = await TheMovieDB.getToprated(state.pageno);
      if (data.results.isNotEmpty) {
        if (data.results.length < 20) {
          state = state.copyWith(
            results: [...oldState, ...data.results],
            isFetchingNext: false,
            hasNext: false,
          );
        } else {
          state = state.copyWith(
            results: [...oldState, ...data.results],
            isFetchingNext: false,
          );
        }
      } else {
        state = state.copyWith(results: [...oldState], isFetchingNext: false);
      }
    } on Exception catch (e) {
      state = state.copyWith(error: e.toString(), isFetchingNext: false);
    }
  }
}
