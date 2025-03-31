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
import 'package:get/get.dart';
import 'package:movie_db/Constants/app_sizes.dart';
import 'package:movie_db/Controllers/homescreen_controller.dart';
import 'package:movie_db/Models/pagination_model.dart';
import 'package:movie_db/Providers/providers.dart';
import 'package:movie_db/Screens/search_screen.dart';
import 'package:movie_db/Screens/seeall_screen.dart';
import 'package:movie_db/Widgets/now_playing.dart';
import 'package:movie_db/Widgets/slider_header.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_db/Widgets/vertical_movie.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PaginationModel popularModel = ref.watch(Providers.popularprovider);
    PaginationModel upcomingModel = ref.watch(Providers.upcomingprovider);
    PaginationModel topratedModel = ref.watch(Providers.topratedprovider);
    Get.put(HomeScreenController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "The Movie DB",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const SearchScreen());
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 280,
                child: Consumer(
                  builder:
                      (context, ref, child) => ref
                          .watch(Providers.nowplayingprovider)
                          .when(
                            loading:
                                () => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            error:
                                (error, _) =>
                                    Center(child: Text(error.toString())),
                            data:
                                (data) => CarouselSlider(
                                  options: CarouselOptions(
                                    height: 280.0,
                                    viewportFraction: 0.91,
                                    autoPlay: true,
                                    autoPlayInterval: 4.seconds,
                                    enableInfiniteScroll: false,
                                    enlargeCenterPage: false,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.height,
                                  ),
                                  items: List.generate(
                                    data.results.length,
                                    (index) => Padding(
                                      padding: EdgeInsets.only(
                                        left: index == 0 ? 5 : 5,
                                        right: 5,
                                      ),
                                      child: NowPlaying(
                                        movie: data.results[index],
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                ),
              ),
              const SizedBox(height: 18),
              SliderHeader(
                title: 'Popular',
                ontap: () {
                  Get.to(() => SeeAllScreen(type: "Popular"));
                },
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: Builder(
                  builder: (context) {
                    if (popularModel.error != '') {
                      return Center(child: Text(popularModel.error));
                    } else if (popularModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (popularModel.results.isEmpty) {
                        return const Center(child: Text("No Results"));
                      } else {
                        var data = popularModel;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.results.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? AppSizes.kdefaultpadding : 0,
                                right: AppSizes.kdefaultpadding,
                              ),
                              child: VerticalMovie(movie: data.results[index]),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 18),
              SliderHeader(
                title: 'Upcoming',
                ontap: () {
                  Get.to(() => SeeAllScreen(type: "Upcoming"));
                },
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: Builder(
                  builder: (context) {
                    if (upcomingModel.error != '') {
                      return Center(child: Text(upcomingModel.error));
                    } else if (upcomingModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (upcomingModel.results.isEmpty) {
                        return const Center(child: Text("No Results"));
                      } else {
                        var data = upcomingModel;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.results.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? AppSizes.kdefaultpadding : 0,
                                right: AppSizes.kdefaultpadding,
                              ),
                              child: VerticalMovie(movie: data.results[index]),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 25),
              SliderHeader(
                title: 'Top Rated',
                ontap: () {
                  Get.to(() => SeeAllScreen(type: "Top Rated"));
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: Builder(
                  builder: (context) {
                    if (topratedModel.error != '') {
                      return Center(child: Text(topratedModel.error));
                    } else if (topratedModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (topratedModel.results.isEmpty) {
                        return const Center(child: Text("No Results"));
                      } else {
                        var data = topratedModel;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.results.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? AppSizes.kdefaultpadding : 0,
                                right: AppSizes.kdefaultpadding,
                              ),
                              child: VerticalMovie(movie: data.results[index]),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
