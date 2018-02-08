//
//  UIImagePickerController+Judge.m
//  相机
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 lgw. All rights reserved.
//

#import "UIImagePickerController+Judge.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>

@implementation UIImagePickerController (Judge)

////检测相册是否可用

-(BOOL)isAvailablePhotoLibrary
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

////相机是否可用
-(BOOL)isAvailableCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
////保存相册功能是否可用
-(BOOL)isAvailbaleSavePhotosAlum
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}
/////后置摄像头
-(BOOL)isAvailableCameraDeviceRear
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
////前置摄像头
-(BOOL)isAvailableCameraDeviceFront
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
/////是否支持拍照权限
-(BOOL)isSupportTaklingPhotos
{
    /////需包含AVFoundation
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted)
    {
        return NO;
    }else
    {
        return YES;
    }
    
}

////判断是否支持某种多媒体类型：拍照，视频
- (BOOL)isSupportsMedia:(NSString *)mediaType sourceType:(UIImagePickerControllerSourceType)sourceType
{
    __block BOOL result = NO;
    if ([mediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:mediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
    
}
// 检查摄像头是否支持录像
- (BOOL) doesCameraSupportShootingVideos{
    return [self isSupportsMedia:( NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypeCamera];
}

/*
 * 8,是否支持获取相册视频权限,是否支持在相册中选择视频
 *
 */
-(BOOL)isSupportPickVideosFromPhotoLibrary
{
    return [self isSupportsMedia:(__bridge NSString *) kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

/*
 * 9,是否支持获取相册图片权限
 *
 */
-(BOOL)isSupportPickPhotoFromPhotoLibrary
{
    return [self isSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

//////检测类型
+ (UIImagePickerController *)imagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController * Pikerimage = [[UIImagePickerController alloc] init];
    ////未设置类型
    // [controller setSourceType:sourceType];
    // [controller setMediaTypes:@[(NSString *)kUTTypeImage]];
    return Pikerimage;
}
@end
