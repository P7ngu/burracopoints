//
//  ReviewRequestManager.swift
//  burracopoints
//
//  Created by Matteo Perotta on 23/05/24.
//

import Foundation
import SwiftUI
import StoreKit

class ReviewRequestManager {
    static let shared = ReviewRequestManager()
    
    private let minimumUsageCount = 2
    private let reviewRequestedKey = "reviewRequested"
    private let appUsageCountKey = "appUsageCount"
    
    func requestReviewIfAppropriate() {
        var count = UserDefaults.standard.integer(forKey: appUsageCountKey)
        count += 1
        UserDefaults.standard.set(count, forKey: appUsageCountKey)
        print("Count: ")
        print(count)
        
        // Check if a review has already been requested
        let reviewRequested = UserDefaults.standard.bool(forKey: reviewRequestedKey)
        
        if count >= minimumUsageCount && reviewRequested && count % 3 == 0 {
            UserDefaults.standard.set(false, forKey: reviewRequestedKey)
        }
        
        // Request review after reaching minimum usage count and if not already requested
        if count >= minimumUsageCount && !reviewRequested {
            requestReview()
            UserDefaults.standard.set(true, forKey: reviewRequestedKey)
        }
    }
    
    private func requestReview() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}
