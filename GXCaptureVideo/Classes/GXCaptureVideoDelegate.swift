//
//  GXCaptureVideoDelegate.swift
//  RSReading
//
//  Created by 高广校 on 2023/12/6.
//

import Foundation

public protocol GXCaptureVideoDelegate: NSObjectProtocol {
    /// 扫码完成
    /// - Parameters:
    ///   - string: 扫码得到的字符
    ///   - error: <#error description#>
    func metadataOutput(_ string: String, completedWithError error: Error?)
}
