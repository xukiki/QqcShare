//
//  ShareProcess.m
//  QqcShareSDK
//
//  Created by qiuqinchuan on 15/2/13.
//  Copyright (c) 2015年 Qqc. All rights reserved.
//

#import "QqcShareProcess.h"
#import "QRCodeGenerator.h"
#import "QqcIncludeShareSdk.h"
#import "QqcQRCodeView.h"

@implementation ShareProcess

#pragma mark - 接口
+ (void)shareWithPlatformType:(QqcSharePlatformType)platformType contentType:(QqcShareContentType)contentType title:(NSString *)strTitle content:(NSString *)strContent url:(NSString *)strUrl musicFileURL:(NSString*)strMusicFileURL image:(NSString *)strImg handle:(QqcShareHandler)handler
{
    if ( ! [ShareProcess iSNeedProcessContinue:platformType handle:handler url:strUrl])
    {
        //不需要继续处理了，直接返回
        handler(QqcShareStatusPreCancel, nil);
    }
    else
    {
        NSMutableDictionary* dicParams = [ShareProcess buildShareParamsWithPlatformType:platformType title:strTitle content:strContent url:strUrl musicFileURL:strMusicFileURL img:strImg contentType:contentType];
        
        [ShareProcess shareWithParams:dicParams platform:platformType handle:handler];
    }
}


+ (void)shareWithPlatformType:(QqcSharePlatformType)platformType contentType:(QqcShareContentType)contentType title:(NSString *)strTitle content:(NSString *)strContent url:(NSString *)strUrl musicFileURL:(NSString*)strMusicFileURL image:(NSString *)strImg parentVC:(UIViewController *)parentVC
{
    [ShareProcess shareWithPlatformType:platformType contentType:contentType title:strTitle content:strContent url:strUrl musicFileURL:strMusicFileURL image:strImg handle:^(QqcShareStatusType state, UIImage *image) {
        if (state == QqcShareStatusFail)
        {
            //[MBProgressHUD showHUD:parentVC text:@"分享失败"];
        }
        else if(state == QqcShareStatusSuccess)
        {
            if (platformType == QqcSharePlatformTypeQRCode && image)
            {
                QqcQRCodeView *codeView = [[QqcQRCodeView alloc] initWithImage:image];
                [codeView show];
            }
            else
            {
                //[MBProgressHUD showHUD:parentVC text:@"分享成功"];
            }
        }
        else if(state == QqcShareStatusCancel)
        {
            //[MBProgressHUD showHUD:parentVC text:@"已取消"];
        }
    }];
}

#pragma mark - 实际调用shareSDK分享功能函数
/**
 *  实际调用shareSDK分享功能函数
 *
 *  @param dicParams      分享参数字典
 *  @param QqcPlatformType 正全定义的分享平台类型
 *  @param handler        回调block
 */
+ (void)shareWithParams:(NSMutableDictionary*)dicParams platform:(QqcSharePlatformType)QqcPlatformType handle:(QqcShareHandler)handler
{
    [ShareSDK share:[ShareProcess shareSDKPlatTypeFromQqcSharePlatType:QqcPlatformType]
         parameters:dicParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         
         if (state == SSDKResponseStateSuccess)
         {
             NSLog(@"分享成功");
             [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
             handler(QqcShareStatusSuccess, nil);
         }
         else if (state == SSDKResponseStateFail)
         {
             NSLog(@"分享失败,错误信息:%@", error);
             handler(QqcShareStatusFail, nil);
         }
         else if (state == SSDKResponseStateCancel)
         {
             NSLog(@"分享取消");
             handler(QqcShareStatusCancel, nil);
         }
     }];
}

#pragma mark - 正全定义的分享类型与ShareSDK定义的分享类型间的转换
/**
 *  由正全定义的分享类型转化为ShareSDK定义的分享类型
 *
 *  @param QqcType 正全定义的分享类型
 *
 *  @return ShareSDK定义的分享类型
 */
+ (SSDKPlatformType)shareSDKPlatTypeFromQqcSharePlatType:(QqcSharePlatformType)QqcType
{
    SSDKPlatformType shareSDKPlatType = SSDKPlatformTypeUnknown;
    switch (QqcType)
    {
        case QqcSharePlatformTypeQQFriend:
            shareSDKPlatType = SSDKPlatformSubTypeQQFriend;
            break;
        case QqcSharePlatformTypeQQZone:
            shareSDKPlatType = SSDKPlatformSubTypeQZone;
            break;
        case QqcSharePlatformTypeSinaWeibo:
            shareSDKPlatType = SSDKPlatformTypeSinaWeibo;
            break;
        case QqcSharePlatformTypeWeixinSession:
            shareSDKPlatType = SSDKPlatformSubTypeWechatSession;
            break;
        case QqcSharePlatformTypeWeixinTimeline:
            shareSDKPlatType = SSDKPlatformSubTypeWechatTimeline;
            break;
        default:
            break;
    }
    
    return shareSDKPlatType;
}


/**
 *  由正全定义的分享内容类型转化为ShareSDK定义的分享内容类型
 *
 *  @param QqcType 正全定义的分享内容类型
 *
 *  @return ShareSDK定义的分享内容类型
 */
+ (SSDKContentType)shareSDKContentTypeFromQqcShareContentType:(QqcShareContentType)QqcType
{
    SSDKContentType shareSDKContentType = SSDKContentTypeWebPage;
    switch (QqcType)
    {
        case QqcShareContentText:
            shareSDKContentType = SSDKContentTypeText;
            break;
        case QqcShareContentImage:
            shareSDKContentType = SSDKContentTypeImage;
            break;
        case QqcShareContentWebPage:
            shareSDKContentType = SSDKContentTypeWebPage;
            break;
        case QqcShareContentAudio:
            shareSDKContentType = SSDKContentTypeAudio;
            break;
        case QqcShareContentVideo:
            shareSDKContentType = SSDKContentTypeVideo;
            break;
        case QqcShareContentApp:
            shareSDKContentType = SSDKContentTypeApp;
            break;
        default:
            break;
    }
    
    return shareSDKContentType;
}

#pragma mark - 业务逻辑
/**
 *  根据传递过来的参数判定是否需要继续往下处理，如果分享类型不明确，或者是分享二维码的话，那么将不需要继续往下处理
 *
 *  @param type    正全定义的分享内容类型
 *  @param handler 回调block
 *  @param strUrl  传递进来的url链接地址
 *
 *  @return 是否需要继续往下处理
 */
+ (BOOL)iSNeedProcessContinue:(QqcSharePlatformType)type handle:(QqcShareHandler)handler url:(NSString *)strUrl
{
    BOOL bIsNeedProcessContinue = YES;
    
    if (type == QqcSharePlatformTypeUnknown)
    {
        bIsNeedProcessContinue = NO;
    }
    else if(type == QqcSharePlatformTypeQRCode)
    {
        handler(QqcShareStatusSuccess, [QRCodeGenerator qrImageForString:strUrl imageSize:182]);
        bIsNeedProcessContinue = NO;
    }
    
    return bIsNeedProcessContinue;
}

#pragma mark - 构建参数
/**
 *  根据参数构建符合ShareSDK分享接口的参数
 *
 *  @param type        正全定义的分享类型
 *  @param strTitle    标题
 *  @param strContent  内容
 *  @param strUrl      链接
 *  @param strImg      图片地址
 *  @param contentType 分享内容类型
 *
 *  @return 参数字典
 */
+ (NSMutableDictionary*)buildShareParamsWithPlatformType:(QqcSharePlatformType)type title:(NSString*)strTitle content:(NSString*)strContent url:(NSString*)strUrl musicFileURL:(NSString*)strMusicFileURL img:(NSString*)strImg contentType:(QqcShareContentType)contentType
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    if (type == QqcSharePlatformTypeSinaWeibo)
    {
        shareParams = [ShareProcess buildSinaWeiboParamsWithPlatformType:type title:strTitle content:strContent url:strUrl img:strImg contentType:contentType];
    }
    else if (type == QqcSharePlatformTypeQQFriend || type == QqcSharePlatformTypeQQZone)
    {
        shareParams = [ShareProcess buildQQParamsWithPlatformType:type title:strTitle content:strContent url:strUrl musicFileURL:strMusicFileURL img:strImg contentType:contentType];
    }
    else if (type == QqcSharePlatformTypeWeixinSession || type == QqcSharePlatformTypeWeixinTimeline)
    {
        shareParams = [ShareProcess buildWXParamsWithPlatformType:type title:strTitle content:strContent url:strUrl img:strImg musicFileURL:strMusicFileURL contentType:contentType];
    }
    
    return shareParams;
}

/**
 *  设置新浪微博分享参数
 *
 *  @param text      文本
 *  @param title     标题
 *  @param image     图片对象，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param url       分享链接
 *  @param latitude  纬度
 *  @param longitude 经度
 *  @param objectID  对象ID，标识系统内内容唯一性，应传入系统中分享内容的唯一标识，没有时可以传入nil
 *  @param type      分享类型，仅支持Text、Image、WebPage（客户端分享时）类型
 */
+ (NSMutableDictionary*)buildSinaWeiboParamsWithPlatformType:(QqcSharePlatformType)type title:(NSString*)strTitle content:(NSString*)strContent url:(NSString*)strUrl img:(NSString*)strImg contentType:(QqcShareContentType)contentType
{
    if (QqcShareContentWebPage == contentType)
    {
        //由于新浪微博不支持 QqcShareContentWebPage，在这里转化类型
        contentType = QqcShareContentImage;
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];

    NSString* strContentNew = [NSString stringWithFormat:@"%@ %@",strContent, strUrl];
    [shareParams SSDKSetupSinaWeiboShareParamsByText:strContentNew
                                               title:strTitle
                                               image:strImg
                                                 url:nil
                                            latitude:0
                                           longitude:0
                                            objectID:nil
                                                type:[ShareProcess shareSDKContentTypeFromQqcShareContentType:contentType]];

    return shareParams;
}

/**
 *  设置QQ分享参数
 *
 *  @param text            分享内容
 *  @param title           分享标题
 *  @param url             分享链接
 *  @param musicFileURL 音乐文件链接地址
 *  @param thumbImage      缩略图，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param image           图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param type            分享类型, 仅支持Text（仅QQFriend）、Image（仅QQFriend）、WebPage、Audio、Video类型
 *  @param platformSubType 平台子类型，只能传入SSDKPlatformSubTypeQZone或者SSDKPlatformSubTypeQQFriend其中一个
 */
+ (NSMutableDictionary*)buildQQParamsWithPlatformType:(QqcSharePlatformType)type title:(NSString*)strTitle content:(NSString*)strContent url:(NSString*)strUrl musicFileURL:(NSString*)strMusicFileURL img:(NSString*)strImg contentType:(QqcShareContentType)contentType
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    if (QqcSharePlatformTypeQQZone==type && QqcShareContentImage==contentType)
    {
        //由于QQ空间不支持 QqcShareContentImage，在这里转化类型
        contentType = QqcShareContentWebPage;
    }
    
    NSURL* urlMusicFile = nil;
    if (strMusicFileURL && ![strMusicFileURL isEqualToString:@""]) {
        urlMusicFile = [NSURL URLWithString:strMusicFileURL];
    }

    [shareParams SSDKSetupQQParamsByText:strContent title:strTitle url:[NSURL URLWithString:strUrl] audioFlashURL:urlMusicFile videoFlashURL:nil thumbImage:strImg images:strImg type:[ShareProcess shareSDKContentTypeFromQqcShareContentType:contentType] forPlatformSubType:[ShareProcess shareSDKPlatTypeFromQqcSharePlatType:type]];
    
    return shareParams;
}

/**
 *  设置微信分享参数
 *
 *  @param text         文本
 *  @param title        标题
 *  @param url          分享链接
 *  @param thumbImage   缩略图，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param image        图片，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
 *  @param musicFileURL 音乐文件链接地址
 *  @param extInfo      扩展信息
 *  @param fileData     文件数据，可以为NSData、UIImage、NSString、NSURL（文件路径）、SSDKData、SSDKImage
 *  @param emoticonData 表情数据，可以为NSData、UIImage、NSURL（文件路径）、SSDKData、SSDKImage
 *  @param type         分享类型，支持SSDKContentTypeText、SSDKContentTypeImage、SSDKContentTypeWebPage、SSDKContentTypeApp、SSDKContentTypeAudio和SSDKContentTypeVideo
 *  @param platformType 平台子类型，只能传入SSDKPlatformTypeWechatSession、SSDKPlatformTypeWechatTimeline和SSDKPlatformTypeWechatFav其中一个
 *
 *  分享文本时：
 *  设置type为SSDKContentTypeText, 并填入text参数
 *
 *  分享图片时：
 *  设置type为SSDKContentTypeImage, 非gif图片时：填入title和image参数，如果为gif图片则需要填写title和emoticonData参数
 *
 *  分享网页时：
 *  设置type为SSDKContentTypeWebPage, 并设置text、title、url以及thumbImage参数，如果尚未设置thumbImage则会从image参数中读取图片并对图片进行缩放操作。
 *
 *  分享应用时：
 *  设置type为SSDKContentTypeApp，并设置text、title、extInfo（可选）以及fileData（可选）参数。
 *
 *  分享音乐时：
 *  设置type为SSDKContentTypeAudio，并设置text、title、url以及musicFileURL（可选）参数。
 *
 *  分享视频时：
 *  设置type为SSDKContentTypeVideo，并设置text、title、url参数
 */
+ (NSMutableDictionary*)buildWXParamsWithPlatformType:(QqcSharePlatformType)type title:(NSString*)strTitle content:(NSString*)strContent url:(NSString*)strUrl img:(NSString*)strImg musicFileURL:(NSString*)strMusicFileURL contentType:(QqcShareContentType)contentType
{
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    NSURL* urlMusicFile = nil;
    if (strMusicFileURL && ![strMusicFileURL isEqualToString:@""]) {
        urlMusicFile = [NSURL URLWithString:strMusicFileURL];
    }

    [shareParams SSDKSetupWeChatParamsByText:strContent title:strTitle url:[NSURL URLWithString:strUrl] thumbImage:strImg image:strImg musicFileURL:urlMusicFile extInfo:nil fileData:nil emoticonData:nil type:[ShareProcess shareSDKContentTypeFromQqcShareContentType:contentType] forPlatformSubType:[ShareProcess shareSDKPlatTypeFromQqcSharePlatType:type]];
    
    return shareParams;
}

@end
