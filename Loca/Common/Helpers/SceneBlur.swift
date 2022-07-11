//
//  SceneBlur.swift
//  Loca
//
//  Created by Margarita Novokhatskaia on 11/07/2022.
//

import UIKit

final class SceneBlur {
    
    func createBluredScreenshotOf(window: UIWindow?) -> UIView {
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        
        var visualEffectView = UIVisualEffectView()
        
        visualEffectView = UIVisualEffectView(effect: blurEffect)
        
        visualEffectView.frame = window?.bounds ?? CGRect()
            
        return visualEffectView
    }
}
