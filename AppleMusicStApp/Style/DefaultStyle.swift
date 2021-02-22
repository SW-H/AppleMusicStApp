//
//  DefaultStyle.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/03/15.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit

public enum DefaultStyle {
    public enum Colors {
        public static let tint: UIColor = {
            if #available(iOS 13.0, *) {
                return UIColor { traitCollction in
                    if traitCollction.userInterfaceStyle == .dark { // 다크모드 여부 확인
                        return .white // 색 지정
                    } else {
                        return .black
                    }
                }
            } else {
                return .black
            }
        }()
    }
}
