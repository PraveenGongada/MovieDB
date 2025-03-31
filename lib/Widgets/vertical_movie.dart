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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_db/Constants/app_colors.dart';
import 'package:movie_db/Controllers/moviescreen_controller.dart';
import '../Models/movie_model.dart';

class VerticalMovie extends StatefulWidget {
  const VerticalMovie({super.key, required this.movie});

  final MovieModel movie;

  @override
  State<VerticalMovie> createState() => _VerticalMovieState();
}

class _VerticalMovieState extends State<VerticalMovie> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Get.isRegistered<MovieScreenController>()) {
          Get.delete<MovieScreenController>();
        }
        Get.toNamed(
          '/MovieScreen',
          arguments: widget.movie,
          preventDuplicates: false,
        );
      },
      child: Container(
        height: 300,
        width: 145,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0XFF171717),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                errorWidget:
                    (context, url, error) => const Text('Error loading image'),
                imageUrl: widget.movie.posterPath!,
                height: 215,
                width: 145,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.movie.title ?? 'Title Here',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.movie.releaseDate?.split('-')[2]} • ${widget.movie.genre?.split(',')[0]}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: DarkModeColors.ksecondarytextColor,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.star_rate_rounded,
                        color: Colors.yellowAccent,
                        size: 18,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${(widget.movie.voteAverage.toString()).substring(0, 3)}  (${widget.movie.voteCount})',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: DarkModeColors.ksecondarytextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
