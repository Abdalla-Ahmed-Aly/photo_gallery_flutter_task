import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SmartImage extends StatelessWidget {
  final bool isOnline;
  final String imageUrl;
  final String cachedFilePath;

  const SmartImage({
    required this.isOnline,
    required this.imageUrl,
    required this.cachedFilePath,
  });

  @override
  Widget build(BuildContext context) {
    if (isOnline) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else {
      final file = File(cachedFilePath);
      if (file.existsSync()) {
        return Image.file(file, fit: BoxFit.cover);
      } else {
        return const Icon(Icons.image_not_supported);
      }
    }
  }
}
