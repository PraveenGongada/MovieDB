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
import 'package:movie_db/Constants/app_sizes.dart';
import 'package:movie_db/Controllers/moviescreen_controller.dart';
import 'package:movie_db/Models/movie_model.dart';

class HorizontalMovie extends StatefulWidget {
  const HorizontalMovie({super.key, required this.movie});

  final MovieModel movie;

  @override
  State<HorizontalMovie> createState() => _HorizontalMovieState();
}

class _HorizontalMovieState extends State<HorizontalMovie> {
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
        margin: EdgeInsets.symmetric(horizontal: AppSizes.kdefaultpadding),
        height: 232,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: DarkModeColors.kcardcolor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: widget.movie.posterPath!,
                height: 215,
                width: MediaQuery.of(context).size.width * 0.35,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.52,
                  child: Text(
                    widget.movie.title ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.movie.releaseDate!,
                  style: TextStyle(
                    fontSize: 14,
                    color: DarkModeColors.ksecondarytextColor,
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.525,
                  child: Text(
                    widget.movie.genre!,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 14,
                      color: DarkModeColors.ksecondarytextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
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
                      '${widget.movie.voteAverage}   (${widget.movie.voteCount} reviews)',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: DarkModeColors.ksecondarytextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.52,
                        child: Text(
                          widget.movie.overview ?? 'No Overview',
                          textAlign: TextAlign.start,
                          maxLines:
                              (constraints.biggest.height / 20).ceil() - 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: DarkModeColors.ksecondarytextColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
