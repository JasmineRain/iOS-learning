//
//  songViewController.h
//  iOS-Music
//
//  Created by OurEDA on 2018/5/2.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "NSString+time.h"
#import <BmobSDK/Bmob.h>
#import <AFNetworking.h>
#import "TFHpple.h"
#import <SDWebImage/UIImageView+WebCache.h>
typedef NS_ENUM(NSInteger, TouchPlayerViewMode) {
    TouchPlayerViewModeNone, // 轻触
    TouchPlayerViewModeHorizontal, // 水平滑动
    TouchPlayerViewModeUnknow, // 未知
};

@protocol NextViewControllerDelegate <NSObject>

- (void)changeNum:(NSString *)tfText;

@end

@interface songViewController : UIViewController
{
    TouchPlayerViewMode _touchMode;
}

@property (nonatomic, assign) id<NextViewControllerDelegate> delegate;

@property (nonatomic, strong)AVPlayer *player;
@property (nonatomic, strong)UISlider *playProgress;
@property (nonatomic, strong)AVPlayerItem *playerItem;
@property (nonatomic, strong)UILabel *leftLabel;
@property (nonatomic, strong)UILabel *rightLabel;
@property (nonatomic, assign)CGFloat sumPlayOperation;
@property (nonatomic, strong)NSString *songId;
@property (nonatomic, strong)NSString *musicId;
@property (nonatomic, strong)NSString *shouldMinus;
@property(strong,nonatomic)NSArray *songList;
@property NSInteger row;

@property (nonatomic, strong)NSString *imageUrl;
@property (nonatomic, strong)UIImageView *coverImg;

@property (nonatomic, strong)UIView *topPanel;
@property (nonatomic, strong)UIView *bottomPanel;

@property (nonatomic, strong)UIImageView *needle;
@property (nonatomic, strong)UIImageView *disc;

@property (nonatomic, strong)CADisplayLink *displayLink;
@property (nonatomic, assign) BOOL isAnimation;

@property (nonatomic, strong)UIButton *likeBtn;
@property (nonatomic, strong)UIButton *downloadBtn;
@property (nonatomic, strong)UIButton *commentBtn;
@property (nonatomic, strong)UIButton *moreBtn;
@property (nonatomic, strong)UIButton *randomBtn;
@property (nonatomic, strong)UIButton *previousBtn;
@property (nonatomic, strong)UIButton *nextBtn;
@property (nonatomic, strong)UIButton *playBtn;
@property (nonatomic, strong)UIButton *listBtn;
@property (strong, nonatomic)UIProgressView *loadedProgress; // 缓冲进度条
// 播放状态
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) BOOL isSliding;
@property (nonatomic, assign) NSString *isLike;
@property (nonatomic, assign) NSString *tempId;
// 播放
- (void)play;

// 暂停
- (void)pause;


@end
