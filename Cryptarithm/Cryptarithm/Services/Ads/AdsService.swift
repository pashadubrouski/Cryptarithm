//
//  AdsService.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 4.11.24.
//

import SwiftUI
import GoogleMobileAds

class AdsService: NSObject, ObservableObject {
    private var bannerView: GADBannerView!
    private var interstitial: GADInterstitialAd?

    // MARK: - Banner Ad Setup
    func loadBannerAd() -> GADBannerView {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2435281174"
        bannerView.rootViewController = UIApplication.shared.windows.first?.rootViewController
        bannerView.load(GADRequest())
        return bannerView
    }

    // MARK: - Interstitial Ad Setup
    func loadInterstitialAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910", request: request) { ad, error in
            if let error = error {
                print("Failed to load interstitial ad: \(error.localizedDescription)")
                return
            }
            self.interstitial = ad
            self.interstitial?.fullScreenContentDelegate = self
        }
    }

    func showInterstitialAd() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("Root view controller is nil.")
            return
        }
        interstitial?.present(fromRootViewController: rootViewController)
    }
}

// MARK: - GADFullScreenContentDelegate
extension AdsService: GADFullScreenContentDelegate {
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        interstitial = nil // Load a new ad after dismissing the current one
    }
}
