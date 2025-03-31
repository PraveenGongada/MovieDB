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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_db/Models/pagination_model.dart';
import 'package:movie_db/Widgets/back_button.dart';
import 'package:movie_db/Widgets/horizontal_movie.dart';
import '../Providers/providers.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  Timer? _debounce;
  ScrollController scrollController = ScrollController();
  PaginationModel? searchProvider;
  SearchNotifier? searchNotifier;

  void _scrollListener() {
    if (searchProvider != null &&
        searchProvider!.hasNext &&
        !searchProvider!.isFetchingNext &&
        scrollController.offset == scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (searchNotifier != null) {
        searchNotifier?.fetchMore();
      }
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    searchProvider = ref.watch(Providers.searchprovider);
    searchNotifier = ref.read(Providers.searchprovider.notifier);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          leading: CustomBack(),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: searchNotifier?.textEditingController,
              focusNode: searchNotifier?.focusNode,
              autofocus: true,
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                if (value.trim() != "") {
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    searchNotifier?.getData(value);
                  });
                } else {
                  searchNotifier?.clearSearch();
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search Movies, TV shows and Actors',
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          actions: [
            Visibility(
              visible:
                  searchNotifier?.textEditingController.text.isNotEmpty ??
                  false,
              child: IconButton(
                icon: const Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  searchNotifier?.clearSearch();
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildChild(searchProvider!, scrollController),
        ),
      ),
    );
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
