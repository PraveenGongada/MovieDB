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

class CastWidget extends StatefulWidget {
  const CastWidget({
    Key? key,
    required this.casturl,
    required this.character,
    required this.name,
  }) : super(key: key);
  final String? casturl;
  final String? character;
  final String? name;

  @override
  State<CastWidget> createState() => _CastWidgetState();
}

class _CastWidgetState extends State<CastWidget> {
  late String character;

  @override
  void initState() {
    super.initState();
    if (widget.character!.contains('/')) {
      var char = widget.character!.split('/');
      character = char[0];
    } else {
      character = widget.character!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            height: 50,
            width: 50,
            color: DarkModeColors.kcardcolor,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.network(
                    widget.casturl != null
                        ? ('https://image.tmdb.org/t/p/w185' + widget.casturl!)
                        : 'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
                    height: 65,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.name!, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            Text(
              character,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                color: DarkModeColors.ksecondarytextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
