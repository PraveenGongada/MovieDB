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
import 'package:movie_db/Constants/app_colors.dart';

class Themes {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: DarkModeColors.kscaffoldcolor,
    colorScheme: ThemeData().colorScheme.copyWith(
      primary: DarkModeColors.kprimarycolor,
    ),
  );
  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: LightModeColors.kscaffoldcolor,
    colorScheme: ThemeData().colorScheme.copyWith(
      primary: LightModeColors.kprimarycolor,
    ),
  );
}
