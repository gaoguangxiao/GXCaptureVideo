//
//  GXCaptureQrCodeViewDelegate.swift
//  RSReading
//
//  Created by 高广校 on 2023/12/6.
//

import Foundation

protocol GXCaptureQrCodeViewDelegate: NSObjectProtocol {
    
    func qrcodeFinish(_ string: String)
}
