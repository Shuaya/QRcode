//
//  SystemFunctions.m
//  Demo-QRcode
//
//  Created by Daniel on 16/6/17.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "SystemFunctions.h"
#import "QRCodeHeader.h"

@implementation SystemFunctions

+ (void)openLight:(BOOL)opened {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![device hasTorch]) {
        
    }
    else {
        if (opened) {
            //开启闪光灯
            if (device.torchMode != AVCaptureTorchModeOn || device.flashMode !=AVCaptureFlashModeOn) {
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                [device unlockForConfiguration];
                
            }
        }
        else {
            //关闭闪关灯
            if (device.torchMode != AVCaptureTorchModeOff || device.flashMode != AVCaptureFlashModeOff){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                [device unlockForConfiguration];
            }
        }
    }
}

+ (void)openShake:(BOOL)shaked Sound:(BOOL)sounding {
    if (shaked) {
        //开启系统震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    if (sounding) {
        //设置自定义声音
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:ringPath ofType:ringType]], &soundID);
        AudioServicesPlaySystemSound(soundID);
    }
}

+ (void)showInSafariWithURLMessage:(NSString *)message Success:(void (^)(NSString *))success Failure:(void (^)(NSError *))failure {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:message]]) {
        success(@"成功跳转");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:message]];
    }
    else{
        NSError *error;
        failure(error);
    }
}
@end
