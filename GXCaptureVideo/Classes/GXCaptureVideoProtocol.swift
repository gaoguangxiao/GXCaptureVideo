//
//  GXCaptureProtocol.swift
//  RSReading
//
//  Created by 高广校 on 2023/12/6.
//

import Foundation

public protocol GXCaptureVideoProtocol {
    
    //MARK: 属性
    var delegate: GXCaptureVideoDelegate? { get set }
    
    //MARK: 方法
    func iniCaptureVideo(preview: UIView,rectOfInterest: CGRect)
    
    func startCapture()
    
    func stopCapture()
}
