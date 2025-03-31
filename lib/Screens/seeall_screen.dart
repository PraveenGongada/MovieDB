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
import 'package:movie_db/Models/pagination_model.dart';
import 'package:movie_db/Widgets/back_button.dart';
import 'package:movie_db/Widgets/horizontal_movie.dart';

import '../Providers/providers.dart';

// ignore: must_be_immutable
class SeeAllScreen extends ConsumerStatefulWidget {
  SeeAllScreen({super.key, required this.type});
  String type;
  @override
  ConsumerState<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends ConsumerState<SeeAllScreen> {
  ScrollController scrollController = ScrollController();
  PaginationModel? paginationModel;
  dynamic notifier;

  void _scrollListener() {
    if (paginationModel!.hasNext &&
        !paginationModel!.isFetchingNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      notifier.fetchMore();
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    paginationModel = getProvider(ref, widget.type);
    notifier = getNotifier(ref, widget.type);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: CustomBack(),
          centerTitle: false,
          title: Text(
            widget.type,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildChild(paginationModel!, scrollController),
        ),
      ),
    );
  }

  PaginationModel? getProvider(WidgetRef ref, String type) {
    if (type == "Popular") {
      return ref.watch(Providers.popularprovider);
    } else if (type == "Upcoming") {
      return ref.watch(Providers.upcomingprovider);
    } else if (type == "Top Rated") {
      return ref.watch(Providers.topratedprovider);
    }
    return null;
  }

  dynamic getNotifier(WidgetRef ref, String type) {
    if (type == "Popular") {
      return ref.read(Providers.popularprovider.notifier);
    } else if (type == "Upcoming") {
      return ref.read(Providers.upcomingprovider.notifier);
    } else if (type == "Top Rated") {
      return ref.read(Providers.topratedprovider.notifier);
    }
  }
}

Widget _buildChild(
  PaginationModel paginationModel,
  ScrollController scrollController,
) {
  if (paginationModel.error != '') {
    return Center(child: Text(paginationModel.error));
  } else if (paginationModel.isLoading) {
    return const Center(child: CircularProgressIndicator());
  } else {
    if (paginationModel.results.isNotEmpty) {
      return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            ListView.separated(
              itemCount: paginationModel.results.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                dynamic result = paginationModel.results[index];
                return Center(child: HorizontalMovie(movie: result));
              },
            ),
            const SizedBox(height: 30),
            if (!paginationModel.hasNext)
              const Center(child: Text("No More Results")),
            if (paginationModel.isFetchingNext)
              const Center(child: CircularProgressIndicator()),
            SizedBox(height: paginationModel.hasNext ? 70 : 30),
          ],
        ),
      );
    } else {
      return const Center(child: Text("No Serach Results"));
    }
  }
}
