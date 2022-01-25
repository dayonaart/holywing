import 'package:app/api/api.dart';
import 'package:app/colors/colors.dart';
import 'package:app/model/carousel_res_model/carousel_data.dart';
import 'package:app/model/carousel_res_model/carousel_res_model.dart';
import 'package:app/model/song_chat_res_model/song_chart_data.dart';
import 'package:app/model/song_chat_res_model/song_chat_res_model.dart';
import 'package:app/widget/loading.dart';
import 'package:app/widget/safe_area.dart';
import 'package:app/widget/space.dart';
import 'package:app/widget/text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(initState: (s) async {
      await _controller.getCarouselProducts();
      await _controller.getSongChart();
    }, builder: (_) {
      return SAFE_AREA(Builder(builder: (context) {
        if (_.carouselData != null && _.songChartData != null) {
          return _mainView(_);
        } else {
          return Center(
              child: SizedBox(height: 100, width: 100, child: Loading().LOADING_ICON(context)));
        }
      }));
    });
  }

  ListView _mainView(HomeController _) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TEXT("Hai, Holypeople",
                      style: const TextStyle(color: Colors.white, fontSize: 20)),
                  Row(
                    children: [
                      Image.asset('assets/ic_qr.png', scale: 3),
                      SPACE(width: 20),
                      Image.asset('assets/ic_notif.png', scale: 3),
                    ],
                  ),
                ],
              ),
              SPACE(),
              if (_.carouselData != null)
                Column(
                  children: [
                    _carousel(_),
                    SPACE(),
                    _accountInfo(),
                    SPACE(),
                    _categories(_),
                    SPACE(),
                    if (_.songChartData != null) _songChart(_)
                  ],
                )
            ],
          ),
        )
      ],
    );
  }

  Card _songChart(HomeController _) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: backgroundColor2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TEXT("Holy People top chart", style: const TextStyle(color: Colors.white)),
            SPACE(),
            Column(
              children: List.generate(_.songChartData!.length, (i) {
                var e = _.songChartData![i];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TEXT(_.place((i + 1)),
                          style: TextStyle(
                              fontSize: _.placeFontSize((i + 1)), color: _.placeColor((i + 1)))),
                      SPACE(),
                      if (e.song?.originalartist?.image != null)
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(e.song!.originalartist!.image!))),
                        )
                      else
                        SizedBox(
                          child: Image.asset('assets/not_found.png', scale: 10),
                          height: 50,
                          width: 50,
                        ),
                      SPACE(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TEXT(e.song?.title, style: const TextStyle(color: Colors.white)),
                          SizedBox(
                            width: Get.width / 1.8,
                            child: TEXT(e.song?.originalartist?.name,
                                style: const TextStyle(color: Colors.white)),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
            SPACE(),
            Row(
              children: List.generate(2, (i) {
                return Expanded(
                    child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                      height: 50,
                      child: Image.asset(
                          i == 0 ? 'assets/ic_apple_music.png' : 'assets/ic_spotify.png')),
                ));
              }),
            )
          ],
        ),
      ),
    );
  }

  Row _categories(HomeController _) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_.categoriesImageAsset.length, (i) {
        return Column(
          children: [
            Image.asset(_.categoriesImageAsset[i], scale: 4),
            SPACE(),
            TEXT(_.categoriesTitle[i], style: const TextStyle(color: Colors.white))
          ],
        );
      }),
    );
  }

  Card _accountInfo() {
    return Card(
      color: backgroundColor2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/ic_login.png', scale: 3),
            SPACE(),
            TEXT("Login to see voucher and point information",
                style: const TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }

  Column _carousel(HomeController _) {
    return Column(
      children: [
        CarouselSlider(
            items: _.carouselData!.map((e) {
              if (e.news?.image != null) {
                return Image.network(
                  e.news!.image!,
                  fit: BoxFit.fill,
                );
              } else {
                return Image.asset('assets/not_found.png');
              }
            }).toList(),
            options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 0.99,
                height: Get.height / 2.5,
                onPageChanged: (i, reason) => _.updateActiveIndex(i))),
        SPACE(),
        Row(
          children: List.generate(_.carouselData!.length, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == _.activeIndex ? Colors.orange : Colors.white),
                height: 10,
                width: 10,
              ),
            );
          }),
        )
      ],
    );
  }
}

class HomeController extends GetxController {
  List<String> categoriesTitle = [
    'Reservation',
    'Dine in',
    "TakeAway",
    "Outlets",
  ];
  List<String> categoriesImageAsset = [
    'assets/ic_reservation.png',
    'assets/ic_home_dinein.png',
    "assets/ic_home_takeaway.png",
    "assets/ic_outlets.png"
  ];
  int activeIndex = 0;
  void updateActiveIndex(int i) {
    activeIndex = i;
    update();
  }

  List<CarouselData>? carouselData;
  Future<void> getCarouselProducts() async {
    var _res = await Api().GET(CAROUSEL, useLoading: false);
    if (_res?.statusCode == 200) {
      carouselData = CarouselResModel.fromJson(_res?.data).carouselData;
      update();
    } else {
      return;
    }
  }

  List<SongChartData>? songChartData;
  Future<void> getSongChart() async {
    var _res = await Api().GET(SONG_CHART, useLoading: false);
    if (_res?.statusCode == 200) {
      songChartData = SongChatResModel.fromJson(_res?.data).songChartData;
      songChartData?.sort((a, b) {
        return a.totalHits!.compareTo(b.totalHits!);
      });
      update();
    } else {
      return;
    }
  }

  String place(int i) {
    switch (i) {
      case 1:
        return "${i}st";
      case 2:
        return "${i}nd";
      case 3:
        return "${i}rd";
      default:
        return "${i}th";
    }
  }

  double placeFontSize(int i) {
    switch (i) {
      case 1:
        return 25;
      case 2:
        return 22;
      case 3:
        return 20;
      default:
        return 16;
    }
  }

  Color placeColor(int i) {
    switch (i) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.orange.withOpacity(0.8);
      case 3:
        return Colors.orange.withOpacity(0.5);

      default:
        return Colors.white;
    }
  }
}
