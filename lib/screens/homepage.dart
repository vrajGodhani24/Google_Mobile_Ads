import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quotes_app/helper/ad_helper.dart';
import 'package:quotes_app/model/quote.dart';
import 'package:quotes_app/utils/all_quotes_data.dart';
import 'package:quotes_app/utils/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  loadAds() async {
    await AdHelper.adHelper.loadBannerAd();
    await AdHelper.adHelper.loadInterstitialAd();
    await AdHelper.adHelper.loadRewardedAd();
    await AdHelper.adHelper.loadAppOpenAd();
  }

  @override
  void initState() {
    super.initState();

    loadAds();

    if (AdHelper.appOpenAd != null) {
      AdHelper.appOpenAd!.show();
    }

    Global.quotes = allQuotes
        .map(
          (e) => Quote.fromMap(data: e),
        )
        .toList();
  }

  bool isExit = false;
  bool isGridView = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Exit"),
                content: const Text("Are you sure to want to exit?"),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      isExit = false;
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      isExit = true;
                    },
                    child: const Text("yes"),
                  ),
                ],
              );
            });
        return isExit;
      },
      // child: Scaffold(
      //   appBar: AppBar(
      //     title: const Text("Quotes"),
      //     actions: [
      //       IconButton(
      //         onPressed: () {
      //           Random random = Random();
      //
      //           int num = random.nextInt(Global.quotes.length - 1);
      //
      //           showDialog(
      //               context: context,
      //               builder: (context) {
      //                 return AlertDialog(
      //                   title: Text("Quote"),
      //                   content: Text(Global.quotes[num].quote),
      //                 );
      //               });
      //         },
      //         icon: const Icon(Icons.recommend_sharp),
      //       ),
      //       IconButton(
      //         onPressed: () {
      //           setState(() {
      //             isGridView = !isGridView;
      //           });
      //         },
      //         icon: Icon(
      //             (isGridView) ? Icons.list_sharp : Icons.grid_view_rounded),
      //       ),
      //     ],
      //   ),
      //   body: Scrollbar(
      //     child: Padding(
      //       padding: const EdgeInsets.all(16),
      //       child: (isGridView)
      //           ? GridView(
      //               gridDelegate:
      //                   const SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //                 crossAxisSpacing: 8,
      //                 mainAxisSpacing: 8,
      //                 childAspectRatio: 3 / 5,
      //               ),
      //               children: Global.quotes
      //                   .map(
      //                     (e) => Container(
      //                       padding: const EdgeInsets.all(10),
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(14),
      //                         color: Colors.black87,
      //                       ),
      //                       width: double.infinity,
      //                       child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Text(
      //                             e.quote,
      //                             style: const TextStyle(
      //                               fontSize: 14,
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                           Align(
      //                             alignment: Alignment.bottomRight,
      //                             child: Text(
      //                               '~ ${e.author}',
      //                               textAlign: TextAlign.end,
      //                               style: const TextStyle(
      //                                 fontSize: 18,
      //                                 color: Colors.white,
      //                                 fontStyle: FontStyle.italic,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   )
      //                   .toList(),
      //             )
      //           : ListView(
      //               children: Global.quotes
      //                   .map(
      //                     (e) => Container(
      //                       padding: const EdgeInsets.all(25),
      //                       margin: const EdgeInsets.only(bottom: 16),
      //                       height: 200,
      //                       decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(20),
      //                         color: Colors.black87,
      //                       ),
      //                       width: double.infinity,
      //                       child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Text(
      //                             e.quote,
      //                             style: const TextStyle(
      //                               fontSize: 15,
      //                               color: Colors.white,
      //                             ),
      //                           ),
      //                           Row(
      //                             mainAxisAlignment: MainAxisAlignment.end,
      //                             children: [
      //                               Text(
      //                                 '~ ${e.author}',
      //                                 style: const TextStyle(
      //                                   fontSize: 18,
      //                                   color: Colors.white,
      //                                   fontStyle: FontStyle.italic,
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   )
      //                   .toList(),
      //             ),
      //     ),
      //   ),
      // ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Google mobile ads"),
        ),
        body: ListView(
          children: [
            SizedBox(height: 150, child: AdWidget(ad: AdHelper.bannerAd!)),
            ElevatedButton(
              onPressed: () async {
                AdHelper.interstitialAd!.show();

                await AdHelper.adHelper.loadInterstitialAd();
              },
              child: Text("Ad"),
            ),
            ElevatedButton(
              onPressed: () async {
                AdHelper.rewardedAd!.show(onUserEarnedReward: (_, amount) {
                  print("Amount: $amount");
                });

                await AdHelper.adHelper.loadRewardedAd();
              },
              child: Text("Rewarded Ad"),
            ),
          ],
        ),
      ),
    );
  }
}
