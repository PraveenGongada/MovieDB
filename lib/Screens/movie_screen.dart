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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movie_db/Constants/app_colors.dart';
import 'package:movie_db/Constants/app_sizes.dart';
import 'package:movie_db/Controllers/moviescreen_controller.dart';
import 'package:movie_db/Providers/providers.dart';
import 'package:movie_db/Widgets/back_button.dart';
import 'package:movie_db/Widgets/cast_widget.dart';
import 'package:movie_db/Widgets/reviews_widget.dart';
import 'package:movie_db/Widgets/slider_header.dart';
import 'package:movie_db/Widgets/vertical_movie.dart';
import 'package:movie_db/Widgets/videos_widget.dart';

class MovieScreen extends ConsumerWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final control = Get.put(MovieScreenController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: CustomBack(),
          title: Text(
            control.movieModel.title ?? "Title Here",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          leadingWidth: 30,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.kdefaultpadding),
            child: Column(
              children: [
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    imageUrl: control.movieModel.posterPath!,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          '${control.movieModel.voteAverage}  (${control.movieModel.voteCount} reviews)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: DarkModeColors.ksecondarytextColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      control.movieModel.genre!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: DarkModeColors.ksecondarytextColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      control.movieModel.releaseDate!,
                      style: TextStyle(
                        fontSize: 14,
                        color: DarkModeColors.ksecondarytextColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Plot',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      control.movieModel.overview ?? "OverView",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: DarkModeColors.ksecondarytextColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Videos',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 150,
                      child: Consumer(
                        builder:
                            (context, ref, child) => ref
                                .watch(
                                  Providers.getvideosprovider(
                                    control.movieModel.id ?? 0,
                                  ),
                                )
                                .when(
                                  loading:
                                      () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  error:
                                      (error, _) =>
                                          Center(child: Text(error.toString())),
                                  data: (data) {
                                    return data.results.isNotEmpty
                                        ? ListView.builder(
                                          itemCount: data.results.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                left: index == 0 ? 0 : 10,
                                              ),
                                              child: VideosWidget(
                                                videourl:
                                                    data.results[index].key,
                                              ),
                                            );
                                          },
                                        )
                                        : const Center(
                                          child: Text('No Videos available'),
                                        );
                                  },
                                ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Cast',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 85,
                      child: Consumer(
                        builder:
                            (context, ref, child) => ref
                                .watch(
                                  Providers.getcastprovider(
                                    control.movieModel.id ?? 0,
                                  ),
                                )
                                .when(
                                  loading:
                                      () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  error:
                                      (error, _) =>
                                          Center(child: Text(error.toString())),
                                  data:
                                      (data) => ListView.builder(
                                        itemCount:
                                            data.cast.length > 25
                                                ? 25
                                                : data.cast.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              left: index == 0 ? 0 : 10,
                                            ),
                                            child: CastWidget(
                                              casturl:
                                                  data.cast[index].profilePath,
                                              character:
                                                  data.cast[index].character ??
                                                  'null',
                                              name:
                                                  data.cast[index].name ??
                                                  'null',
                                            ),
                                          );
                                        },
                                      ),
                                ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Consumer(
                      builder:
                          (context, ref, child) => ref
                              .watch(
                                Providers.getreviewsprovider(
                                  control.movieModel.id ?? 0,
                                ),
                              )
                              .when(
                                loading:
                                    () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                error:
                                    (error, stackTrace) =>
                                        Center(child: Text(error.toString())),
                                data: (data) {
                                  return data.results.isEmpty
                                      ? const Column(
                                        children: [
                                          Text(
                                            'Reviews',
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text('No Reviews'),
                                        ],
                                      )
                                      : Column(
                                        children: [
                                          SliderHeader(
                                            hpadding: 0.0,
                                            title: 'Reviews',
                                            ontap: () {
                                              showBottomSheet(
                                                context: context,
                                                builder:
                                                    (context) => Scaffold(
                                                      appBar: AppBar(
                                                        title: Container(
                                                          height: 5,
                                                          width: 50,
                                                          decoration: const BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                  Radius.circular(
                                                                    32,
                                                                  ),
                                                                ),
                                                          ),
                                                        ),
                                                        toolbarHeight: 40,
                                                        automaticallyImplyLeading:
                                                            false,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                      ),
                                                      body: Container(
                                                        color: Colors.black,
                                                        child: ListView.builder(
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                horizontal:
                                                                    AppSizes
                                                                        .kdefaultpadding,
                                                              ),
                                                          itemCount:
                                                              data.totalResults,
                                                          itemBuilder:
                                                              (
                                                                context,
                                                                index,
                                                              ) => ReviewsWidget(
                                                                imageurl:
                                                                    data
                                                                        .results[index]
                                                                        .authorDetails
                                                                        .avatarPath,
                                                                rating:
                                                                    data
                                                                        .results[index]
                                                                        .authorDetails
                                                                        .rating,
                                                                name:
                                                                    data
                                                                        .results[index]
                                                                        .author,
                                                                review:
                                                                    data
                                                                        .results[index]
                                                                        .content,
                                                                maxlines: 100,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                              );
                                            },
                                          ),
                                          const SizedBox(height: 15),
                                          ReviewsWidget(
                                            imageurl:
                                                data
                                                    .results[0]
                                                    .authorDetails
                                                    .avatarPath,
                                            rating:
                                                data
                                                    .results[0]
                                                    .authorDetails
                                                    .rating,
                                            name: data.results[0].author,
                                            review: data.results[0].content,
                                            maxlines: 5,
                                          ),
                                        ],
                                      );
                                },
                              ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Similar',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 300,
                      child: Consumer(
                        builder:
                            (context, ref, child) => ref
                                .watch(
                                  Providers.getsimilarprovider(
                                    control.movieModel.id ?? 0,
                                  ),
                                )
                                .when(
                                  loading:
                                      () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  error:
                                      (error, stackTrace) =>
                                          Center(child: Text(error.toString())),
                                  data: (data) {
                                    if (data.results.isEmpty) {
                                      return const Center(
                                        child: Text('No Similar Movies'),
                                      );
                                    } else {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: data.results.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              left:
                                                  index == 0
                                                      ? 0
                                                      : AppSizes
                                                          .kdefaultpadding,
                                            ),
                                            child: VerticalMovie(
                                              movie: data.results[index],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Recommendations',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 300,
                      child: Consumer(
                        builder:
                            (context, ref, child) => ref
                                .watch(
                                  Providers.getrecommendationsprovider(
                                    control.movieModel.id ?? 0,
                                  ),
                                )
                                .when(
                                  loading:
                                      () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  error:
                                      (error, stackTrace) =>
                                          Center(child: Text(error.toString())),
                                  data: (data) {
                                    if (data.results.isEmpty) {
                                      return const Center(
                                        child: Text('No Recommendations'),
                                      );
                                    } else {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: data.results.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              left:
                                                  index == 0
                                                      ? 0
                                                      : AppSizes
                                                          .kdefaultpadding,
                                            ),
                                            child: VerticalMovie(
                                              movie: data.results[index],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
