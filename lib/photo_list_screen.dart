import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class PhotoListScreen extends StatefulWidget {
  static const String routName = '/photolistscreen';

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  bool isOnline = true;
  bool isDarkMode = false;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      if (mounted) {
        setState(() {
          isOnline =
              results.isNotEmpty && results.first != ConnectivityResult.none;
        });
      }
    });
  }

  Future<void> _initConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      isOnline = result != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/routeLogo-dark.png',
              height: 60,
              width: 100,
              color: Colors.blueAccent,
              // color: Colors.white,
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
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.pexels.com/photos/3573351/pexels-photo-3573351.png?auto=compress&cs=tinysrgb&h=130',
                    ),
                    fit: BoxFit.contain,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}