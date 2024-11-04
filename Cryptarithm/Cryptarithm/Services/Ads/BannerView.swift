//
//  BannerView.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 4.11.24.
//

import SwiftUI
import GoogleMobileAds

struct BannerAdView: UIViewRepresentable {
    let adsManager: AdsService
    func makeUIView(context: Context) -> GADBannerView {
        return adsManager.loadBannerAd()
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {}
}
