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
import 'package:get/get.dart';
import 'package:movie_db/Controllers/homescreen_controller.dart';
import 'package:movie_db/Keys/keys.dart';
import 'package:movie_db/Models/cast_model.dart';
import 'package:movie_db/Models/nowandupcoming_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_db/Models/popularandtoprated_model.dart';
import 'package:movie_db/Models/recommendations_model.dart';
import 'package:movie_db/Models/reviews_model.dart';
import 'package:movie_db/Models/searach_model.dart';
import 'package:movie_db/Models/similar_model.dart';
import 'package:movie_db/Models/videos_model.dart';

abstract class TheMovieDB {
  static Future<NowandUpcomingModel> getnowplaying() async {
    const String url =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=${Keys.tmdb_key}&language=en-US&region=US&page=1';
    final response = await http.get(Uri.parse(url));

    final data = nowandupcomingFromJson(response.body);

    if (response.statusCode == 200) {
      Get.find<HomeScreenController>().nowplaying = data;
    }

    return data;
  }

  static Future<PopularandTopRatedModel> getpopular(int page) async {
    String url =
        'https://api.themoviedb.org/3/movie/popular?api_key=${Keys.tmdb_key}&language=en-US&region=US&page=$page';
    final response = await http.get(Uri.parse(url));

    final data = popularandTopRatedModelFromJson(response.body);

    if (response.statusCode == 200) {
      Get.find<HomeScreenController>().popular = data;
    }

    return data;
  }

  static Future<PopularandTopRatedModel> getToprated(int page) async {
    String url =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=${Keys.tmdb_key}&language=en-US&page=$page';
    final response = await http.get(Uri.parse(url));

    final data = popularandTopRatedModelFromJson(response.body);

    if (response.statusCode == 200) {
      Get.find<HomeScreenController>().toprated = data;
    }

    return data;
  }

  static Future<NowandUpcomingModel> getupcoming(int pageno) async {
    String url =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=${Keys.tmdb_key}&language=en-US&region=US&page=$pageno';
    final response = await http.get(Uri.parse(url));

    final data = nowandupcomingFromJson(response.body);

    if (response.statusCode == 200) {
      Get.find<HomeScreenController>().upcoming = data;
    }

    return data;
  }

  static Future<SimilarModel> getsimilar(int movieid) async {
    String url =
        'http://api.themoviedb.org/3/movie/$movieid/similar?api_key=${Keys.tmdb_key}&language=en-US&page=1';

    final response = await http.get(Uri.parse(url));

    final data = similarModelFromJson(response.body);

    return data;
  }

  static Future<SearchModel> getSearchResults(String query, int page) async {
    String url =
        'http://api.themoviedb.org/3/search/movie?query=$query&api_key=${Keys.tmdb_key}&language=en-US&page=$page';

    final response = await http.get(Uri.parse(url));

    final data = searchModelFromJson(response.body);

    return data;
  }

  static Future<RecommendationsModel> getrecommendations(int movieid) async {
    String url =
        'http://api.themoviedb.org/3/movie/$movieid/recommendations?api_key=${Keys.tmdb_key}&language=en-US&page=1';

    final response = await http.get(Uri.parse(url));

    final data = recommendationsModelFromJson(response.body);

    return data;
  }

  static Future<VideosModel> getvideos(int movieid) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieid/videos?api_key=${Keys.tmdb_key}&language=en-US';
    final response = await http.get(Uri.parse(url));

    final data = videosModelFromJson(response.body);

    return data;
  }

  static Future<CastModel> getcast(int movieid) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieid/credits?api_key=${Keys.tmdb_key}&language=en-US';
    final response = await http.get(Uri.parse(url));

    Map<String, dynamic> json = jsonDecode(response.body);

    final data = CastModel.fromJson(json);
    return data;
  }

  static Future<ReviewsModel> getreviews(int movieid) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieid/reviews?api_key=${Keys.tmdb_key}&language=en-US&page=1';
    final response = await http.get(Uri.parse(url));

    final data = reviewsModelFromJson(response.body);

    return data;
  }
}
