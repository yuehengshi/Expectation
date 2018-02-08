//
//  UIImagePickerController+Judge.h
//  相机
//
//  Created by apple on 16/5/19.
//  Copyright © 2016年 lgw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (Judge)

/*
 * 1,检测相册是否可用
 *
 *
 *
*/
-(BOOL)isAvailablePhotoLibrary;


/**
 * 2,检测设备是否有摄像头
 *
 *
 */
-(BOOL)isAvailableCamera;

/**
 * 3,是否可以保存到相册
 *
 */
-(BOOL)isAvailbaleSavePhotosAlum;

/*
 * 4,后置摄像头是否可用
 *
 */
-(BOOL)isAvailableCameraDeviceRear;


/*
 * 5,前置摄像头是否可用
 *
 */
-(BOOL)isAvailableCameraDeviceFront;

/*
 * 6,是否支持拍照权限
 *
 */
-(BOOL) isSupportTaklingPhotos;
/*
 * 7,判断摄像头是否支持录像
 *
 */
- (BOOL) doesCameraSupportShootingVideos;

/*
 * 8,是否支持获取相册视频权限
 *
 */
-(BOOL)isSupportPickVideosFromPhotoLibrary;
/*
 * 9,是否支持获取相册图片权限
 *
 */
-(BOOL)isSupportPickPhotoFromPhotoLibrary;


/////检测类型
+ (UIImagePickerController *)imagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType;













@end
