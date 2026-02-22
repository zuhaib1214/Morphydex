import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:morphydex/data/network/firebase/auth_services.dart';
import 'package:morphydex/res/app_color.dart';
import 'package:morphydex/view/home/components/home_buttons.dart';
import 'package:morphydex/view/home/components/home_upper_section.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Baby Health classification',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuthService.logout(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              HomeUpperPortion(),
              const SizedBox(
                height: 20,
              ),

              const CarouselWithLink(),

              const SizedBox(
                height: 40,
              ),
              // const HomeMainSection(),
              const HomeButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class CarouselWithLink extends StatelessWidget {
  const CarouselWithLink({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        ...[
          'assets/banner/b1.jpg',
          'assets/banner/b2.png',
          'assets/banner/b3.png',
        ].map(
          (e) => GestureDetector(
            onTap: () {
              _launchURL();
              // _openURL();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: primaryColor,
                  width: 2,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  e,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        aspectRatio: 2.3,
        viewportFraction: 0.75,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
      ),
    );
  }

  void openURL() async {
    const url = 'https://ncdalliance.org/why-ncds/ncds/cancer?gad_source=1';
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchURL() async {
    const url = 'https://ncdalliance.org/why-ncds/ncds/cancer?gad_source=1';
    try {
      if (await canLaunchUrl(
        Uri.parse(url),
      )) {
        await launchUrl(
          Uri.parse(url),
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
