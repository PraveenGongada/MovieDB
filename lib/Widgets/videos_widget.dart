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
import 'package:get/get.dart';
import 'package:movie_db/Constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class VideosWidget extends StatelessWidget {
  const VideosWidget({Key? key, required this.videourl}) : super(key: key);

  final String videourl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch('https://www.youtube.com/watch?v=$videourl')) {
          await launch('https://www.youtube.com/watch?v=$videourl');
        } else {
          const GetSnackBar(title: "Can't launch url");
        }
      },
      child: SizedBox(
        height: 210,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 210,
              color: DarkModeColors.kcardcolor,
              child: Image.network(
                'https://i.ytimg.com/vi/$videourl/hqdefault.jpg',
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => const Text('Unavailable'),
              ),
            ),
            Center(child: Image.asset('assets/icons/youtube.png', height: 40)),
          ],
        ),
      ),
    );
  }
}
