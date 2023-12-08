//
//  GXCaptureVideo.swift
//  RSReading
//
//  Created by 高广校 on 2023/12/6.
//

import Foundation
import AVFoundation

public class GXCaptureVideo: NSObject, GXCaptureVideoProtocol{
    // MARK: - Properties (GXCaptureVideoProtocol)
    public var delegate: GXCaptureVideoDelegate?
    
    //    MARK: property
    private(set) var videoDevices = [AVCaptureDevice]()
    
    fileprivate lazy var videoQueue = DispatchQueue.global()

    private var captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    public func iniCaptureVideo(preview: UIView) {
        
        //1.开始
        captureSession.beginConfiguration()
        
        // 2.设置输入源(摄像头)
        // 2.设置输入源(摄像头)
        // 2.1.获取摄像头
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        // 2.2.通过 device 创建 AVCaptureInput 对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        // 2.3.将 input 添加到会话中
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }

//        3.设置输出源
        setMetadataOutput()
        
        captureSession.commitConfiguration()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.frame = preview.bounds
        previewLayer?.videoGravity = .resizeAspectFill
        preview.layer.insertSublayer(previewLayer!, at: 0)
    }
    
    public func startCapture() {
        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
    }
    
    public func stopCapture() {
        captureSession.stopRunning()
    }
    
    private func getVideoDevices() -> [AVCaptureDevice] {
        //广角、长焦
        var deviceTypes:[AVCaptureDevice.DeviceType] = [.builtInWideAngleCamera, .builtInTelephotoCamera]
        if #available(iOS 10.2, *) {
            //双摄广角
            deviceTypes.append(.builtInDualCamera)
        }
        if #available(iOS 11.1, *) {
            //组合
            deviceTypes.append(.builtInTrueDepthCamera)
        }
        if #available(iOS 13.0, *) {
            //超广角、超广角+广角、超广角+广角+长焦
            deviceTypes += [.builtInUltraWideCamera, .builtInDualWideCamera, .builtInTripleCamera]
        }
        let deviceSession = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: .video, position: .back)
         return deviceSession.devices
    }
}

extension GXCaptureVideo {
 
    //设置二维码输入源
    func setMetadataOutput() {
        //设置输入
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
        }
//        3.1限制扫码区域
        
//        3.2指定输出的元数据类型为 条形码 二维码 类型
        //二维码【https://www.jianshu.com/p/6ec37d9307b8】
        let dstTypes: [AVMetadataObject.ObjectType] = [.qr,.pdf417,.aztec,.dataMatrix]

        let availableMOTypes = metadataOutput.availableMetadataObjectTypes
        
        let validTypes = dstTypes.filter { availableMOTypes.contains($0)}

        metadataOutput.metadataObjectTypes = validTypes
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: videoQueue)
    }
}
