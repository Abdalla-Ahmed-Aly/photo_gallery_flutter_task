import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_gallery_flutter_task/core/Theam/ThemeCubit.dart';
import 'package:photo_gallery_flutter_task/core/widget/Shimmer.dart';
import 'package:photo_gallery_flutter_task/core/widget/ThemeToggleWidget.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/view/presentation/cubit/photo_cubit.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/view/presentation/cubit/photo_state.dart';

class PhotoListScreen extends StatefulWidget {
  static const String routName = '/photolistscreen';

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  bool isOnline = true;
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  late ScrollController _scrollController;
  int currentPage = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<PhotoCubit>().loadPhotosFromCache();
    _initConnectivity();
    _subscription = Connectivity().onConnectivityChanged.listen(
      _onConnectivityChanged,
    );
  }

  Future<void> _initConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    final online = result != ConnectivityResult.none;
    setState(() => isOnline = online);
    context.read<PhotoCubit>().setOnlineStatus(online);
    if (online) {
      context.read<PhotoCubit>().fetchPhotos(page: currentPage);
    }
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    if (!mounted) return;
    final online =
        results.isNotEmpty && results.first != ConnectivityResult.none;
    setState(() => isOnline = online);
    context.read<PhotoCubit>().setOnlineStatus(online);
    if (online) {
      currentPage = 1;
      context.read<PhotoCubit>().fetchPhotos(page: currentPage);
    }
  }

   void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore) {
      isLoadingMore = true;
      currentPage++;
      context.read<PhotoCubit>().fetchPhotos(page: currentPage).then((_) {
        isLoadingMore = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/routeLogo-dark.png',
              height: 60,
              width: 100,
              color: isDark ? Colors.white : Colors.blueAccent,
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: isOnline ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 12),
                ThemeToggleButton(),
              ],
            ),
          ],
        ),
      ),
      body: BlocBuilder<PhotoCubit, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoading) {
            return MasonryGridView.count(
              controller: _scrollController,
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              padding: const EdgeInsets.all(12),
              itemCount: 10,
              itemBuilder: (_, __) =>
                  const AspectRatio(aspectRatio: 3 / 4, child: ShimmerItem()),
            );
          } else if (state is PhotoLoaded) {
            final photos = state.photos;

            if (photos.isEmpty) {
              return const Center(child: Text("لا توجد صور لعرضها حالياً"));
            }

            return MasonryGridView.count(
              controller: _scrollController,
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              padding: const EdgeInsets.all(12),
  itemCount: photos.length + (isLoadingMore ? 2 : 0), 
              itemBuilder: (context, index) {
                final photo = photos[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child:  CachedNetworkImage(
                    imageUrl: photo.src?.medium ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const AspectRatio(
                      aspectRatio: 3 / 4,
                      child: ShimmerItem(),
                    ),
                    errorWidget: (context, url, error) {return Image.asset('assets/images/882-200x300.jpg',fit: BoxFit.cover,);}
                  ),
                );
              },
            );
          } else if (state is PhotoError) {
            context.read<PhotoCubit>().loadPhotosFromCache();
            return const Center(
              child: Text(
                "لا توجد صور في الكاش حالياً.\nيرجى الاتصال بالإنترنت لتحميل الصور لأول مرة.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            );
          } else {
            return const Center(child: Text("جارٍ تحميل الصور من الكاش..."));
          }
        },
      ),
    );
  }
}
