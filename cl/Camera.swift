//
//  Camera.swift
//  cl
//
//  Created by wujiadong on 16/9/18.
//  Copyright © 2016年 wujiadong. All rights reserved.
//


import UIKit
import AVFoundation

class Camera: UIImageView {
    
//    var stillImageOutput: AVCaptureStillImageOutput!
//    var session: AVCaptureSession!
//    
//    func configureCamera() -> Bool {
//        // init camera device
//        var captureDevice: AVCaptureDevice?
//        let devices: NSArray = AVCaptureDevice.devices()
//        
//        // find back camera
//        for device: AnyObject in devices {
//            if device.position == AVCaptureDevicePosition.Back {
//                captureDevice = device as? AVCaptureDevice
//            }
//        }
//        
//        if captureDevice != nil {
//            // Debug
//            print(captureDevice!.localizedName)
//            print(captureDevice!.modelID)
//        } else {
//            print("Missing Camera")
//            return false
//        }
//        
//        // init device input
//        do {
//            let deviceInput: AVCaptureInput = try AVCaptureDeviceInput(device: captureDevice) as AVCaptureInput
//            
//            self.stillImageOutput = AVCaptureStillImageOutput()
//            
//            // init session
//            self.session = AVCaptureSession()
//            self.session.sessionPreset = AVCaptureSessionPresetPhoto
//            self.session.addInput(deviceInput as AVCaptureInput)
//            self.session.addOutput(self.stillImageOutput)
//            
//            // layer for preview
//            let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session) as AVCaptureVideoPreviewLayer
//            previewLayer.frame = self.view.bounds
//            self.view.layer.addSublayer(previewLayer)
//            
//            self.session.startRunning()
//        }
//        catch {
//            // handle error here
//        }
//        return true
//    }
    
}
