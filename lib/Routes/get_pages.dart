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

import 'package:get/get.dart';
import 'package:movie_db/Screens/home_screen.dart';
import 'package:movie_db/Screens/movie_screen.dart';

abstract class GetPages {
  static List<GetPage> getpages = <GetPage>[
    GetPage(name: '/HomeScreen', page: () => const HomeScreen()),
    GetPage(name: '/MovieScreen', page: () => const MovieScreen()),
  ];
}
