//
//  GXCaptureVideo+CaptureMetadataOutputObjectsDelegate.swift
//  RSReading
//
//  Created by 高广校 on 2023/12/6.
//

import AVFoundation

extension GXCaptureVideo: AVCaptureMetadataOutputObjectsDelegate {
    
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        let metadataObject = metadataObjects.first
        if let codeObject = metadataObject as? AVMetadataMachineReadableCodeObject ,let str = codeObject.stringValue {
            delegate?.metadataOutput(str, completedWithError: nil)
        }
        
    }
}
