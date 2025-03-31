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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

import '../Constants/movie_genres.dart';

class MovieModel {
  bool? adult;
  String? backdropPath;
  String? genre;
  int? id;
  String? mongoId;
  String? title;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  String? voteCount;

  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genre,
    required this.id,
    required this.mongoId,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'backdropPath': backdropPath,
      'genre': genre,
      'id': id,
      'title': title,
      'originalTitle': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'video': video,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      adult: map['adult'] != null ? map['adult'] as bool : null,
      backdropPath: getBackdropURL(map['backdrop_path']),
      genre: getgenre(map['genre_ids'] as List<dynamic>?),
      id: map['id'] != null ? map['id'] as int : null,
      mongoId: null,
      title: map['title'] != null ? map['title'] as String : null,
      originalTitle:
          map['original_title'] != null
              ? map['original_title'] as String
              : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
      popularity:
          map['popularity'] != null ? map['popularity'].toDouble() : null,
      posterPath: getPosterURL(map['poster_path']),
      releaseDate: getReleasedate(
        map['release_date'] != ""
            ? DateTime.parse(map['release_date'])
            : DateTime.now(),
      ),
      video: map['video'] != null ? map['video'] as bool : null,
      voteAverage:
          map['vote_average'] != null
              ? double.parse(map['vote_average'].toStringAsFixed(1))
              : null,
      voteCount: getVotesinK(map['vote_count']),
    );
  }

  factory MovieModel.fromLocalJson(Map<String, dynamic> json) => MovieModel(
    adult: json["adult"],
    backdropPath: json["backdropPath"],
    genre: json["genre"],
    id: json["id"],
    mongoId: json["_id"],
    title: json["title"],
    originalTitle: json["originalTitle"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["posterPath"],
    video: json["video"],
    voteAverage: json["voteAverage"]?.toDouble(),
    releaseDate: json["releaseDate"],
    voteCount: json["voteCount"],
  );

  factory MovieModel.fromJsonString(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static String getgenre(List<dynamic>? genres) {
    String genre = "";
    if (genres != null) {
      for (int i = 0; i < genres.length; i++) {
        MovieGenres.genres.forEach((key, value) {
          if (genres[i] == key) {
            genre = genre + value;
          }
        });
        genre = genre + (i == genres.length - 1 ? '' : ', ');
      }
      return genre;
    } else {
      return "No Genre";
    }
  }

  static String getVotesinK(int? votes) {
    return votes != null ? NumberFormat.compact().format(votes) : "0";
  }

  static String getPosterURL(String? poster) {
    String posterURL =
        poster != null
            ? ('https://image.tmdb.org/t/p/w780$poster')
            : 'https://res.cloudinary.com/people-matters/image/upload/q_auto,f_auto/v1517845732/1517845731.jpg';
    return posterURL;
  }

  static String getBackdropURL(String? backdrop) {
    if (backdrop != null) {
      return ('https://image.tmdb.org/t/p/w780$backdrop');
    } else {
      return 'https://media.istockphoto.com/photos/warning-concept-yellow-exclamation-point-glowing-amid-black-points-picture-id1305170062?b=1&k=20&m=1305170062&s=170667a&w=0&h=q6mAXN4dsnulYh2jMaTkVPacNVKU_vr7Sz_JhnXguyQ=';
    }
  }

  static String getReleasedate(DateTime? releaseDate) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    if (releaseDate != null) {
      return dateFormat.format(releaseDate);
    } else {
      return "Unavailable";
    }
  }

  @override
  String toString() {
    return 'MovieModel(adult: $adult, backdropPath: $backdropPath, genre: $genre, id: $id, title: $title, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, video: $video, voteAverage: $voteAverage, voteCount: $voteCount)';
  }

  @override
  bool operator ==(covariant MovieModel other) {
    if (identical(this, other)) return true;

    return other.adult == adult &&
        other.backdropPath == backdropPath &&
        other.genre == genre &&
        other.id == id &&
        other.title == title &&
        other.originalTitle == originalTitle &&
        other.overview == overview &&
        other.popularity == popularity &&
        other.posterPath == posterPath &&
        other.releaseDate == releaseDate &&
        other.video == video &&
        other.voteAverage == voteAverage &&
        other.voteCount == voteCount;
  }

  @override
  int get hashCode {
    return adult.hashCode ^
        backdropPath.hashCode ^
        genre.hashCode ^
        id.hashCode ^
        title.hashCode ^
        originalTitle.hashCode ^
        overview.hashCode ^
        popularity.hashCode ^
        posterPath.hashCode ^
        releaseDate.hashCode ^
        video.hashCode ^
        voteAverage.hashCode ^
        voteCount.hashCode;
  }

  String toJson() => json.encode(toMap());
}
