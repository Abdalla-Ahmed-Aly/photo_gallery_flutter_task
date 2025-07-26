import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_gallery_flutter_task/core/Theam/ThemeCubit.dart';
import 'package:photo_gallery_flutter_task/core/widget/Shimmer.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/view/presentation/cubit/photo_cubit.dart';
import 'package:photo_gallery_flutter_task/features/photo_list/view/presentation/cubit/photo_state.dart';

class PhotoListScreen extends StatefulWidget {
  static const String routName = '/photolistscreen';

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  bool isOnline = true;
  bool isDarkMode = false;

  late StreamSubscription<List<ConnectivityResult>> _subscription;
  late ScrollController _scrollController;
  int currentPage = 1;
  bool isLoadingMore = false;
  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _scrollController = ScrollController()..addListener(_onScroll);
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      if (mounted) {
        setState(() {
          isOnline =
              results.isNotEmpty && results.first != ConnectivityResult.none;
        });
      }
    });
    context.read<PhotoCubit>().fetchPhotos(page: currentPage);
  }

  Future<void> _initConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      isOnline = result != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _subscription.cancel();

    super.dispose();
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
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemeCubit>().state == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/routeLogo-dark.png',
              height: 60,
              width: 100,
              color: isDarkMode ? Colors.white : Colors.blueAccent,
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
                AnimatedToggleSwitch<bool>.dual(
                  current: isDarkMode,
                  first: false,
                  second: true,
                  spacing: 3.0,
                  height: 30,
                  indicatorSize: const Size.square(25),
                  style: ToggleStyle(
                    borderRadius: BorderRadius.circular(20.0),
                    backgroundColor: Colors.grey.shade300,
                  ),
                  customIconBuilder: (context, value, size) {
                    return Icon(
                      value.value ? Icons.dark_mode : Icons.light_mode,
                      size: 18,
                      color: value.value ? Colors.white : Colors.orange,
                    );
                  },
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
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
              itemBuilder: (context, index) =>
                  const AspectRatio(aspectRatio: 3 / 4, child: ShimmerItem()),
            );
          } else if (state is PhotoLoaded) {
            final photos = state.photos;
            return MasonryGridView.count(
              controller: _scrollController,
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              padding: const EdgeInsets.all(12),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    photo.src?.medium ?? '',
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const AspectRatio(
                        aspectRatio: 3 / 4,
                        child: ShimmerItem(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                );
              },
            );
          } else if (state is PhotoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
