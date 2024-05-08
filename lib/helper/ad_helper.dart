import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  AdHelper._();

  static final AdHelper adHelper = AdHelper._();

  static BannerAd? bannerAd;
  static InterstitialAd? interstitialAd;
  static RewardedAd? rewardedAd;
  static AppOpenAd? appOpenAd;

  Future<void> loadBannerAd() async {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener: const BannerAdListener(),
      request: const AdRequest(),
    );

    await bannerAd!.load();
  }

  Future<void> loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: "ca-app-pub-3940256099942544/1033173712",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print("Error :- $error");
        },
      ),
    );
  }

  Future<void> loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: "ca-app-pub-3940256099942544/5224354917",
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          rewardedAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print("Error :- $error");
        },
      ),
    );
  }

  Future<void> loadAppOpenAd() async {
    await AppOpenAd.load(
      adUnitId: "ca-app-pub-3940256099942544/9257395921",
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (AppOpenAd ad) {
          appOpenAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print("Error :- $error");
        },
      ),
    );
  }
}
