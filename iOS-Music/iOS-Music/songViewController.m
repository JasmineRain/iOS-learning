//
//  songViewController.m
//  iOS-Music
//
//  Created by OurEDA on 2018/5/2.
//  Copyright © 2018年 OurEDA. All rights reserved.
//

#import "songViewController.h"

@interface songViewController ()
{
    id _playTimeObserver; // 观察者
}
@end

@implementation songViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *lightGrey= [UIColor colorWithRed:57/255.0 green:57/255.0 blue:57/255.0 alpha:1];
    self.view.backgroundColor = lightGrey;
    CGRect screen=[[UIScreen mainScreen] bounds];
    self.isSliding=NO;
    
    UIBarButtonItem* backBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnPressed:)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
    UIBarButtonItem* shareBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"分享.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnPressed:)];
    self.navigationItem.rightBarButtonItem = shareBtnItem;
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.disc = [[UIImageView alloc] initWithFrame:CGRectMake((screen.size.width-260)/2, 150, 260, 260)];
    [self.disc setImage:[UIImage imageNamed:@"disc.png"]];
    [self.view addSubview:self.disc];
    self.coverImg = [[UIImageView alloc] initWithFrame:CGRectMake((screen.size.width-160)/2, 200, 160, 160)];
    self.coverImg.layer.masksToBounds =YES;
    
    self.coverImg.layer.cornerRadius =80;
    
    self.coverImg.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImg.clipsToBounds=YES;
    [self.view addSubview:_coverImg];
    
    
    [self.coverImg.layer addAnimation:[self getAnimation] forKey:@"imageCover-layer"];
    
    NSLog(@"from songVC %@",self.imageUrl);
    
    [self.coverImg sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]
                 placeholderImage:[UIImage imageNamed:@"defaultCover.jpg"]];
    
    
    self.needle = [[UIImageView alloc] initWithFrame:CGRectMake(screen.size.width/2-30, 30, 100, 180)];
    [self.needle setImage:[UIImage imageNamed:@"needle.png"]];
    [self.view addSubview:self.needle];
    
    
//--------------------------player part--------
    NSString *urlString = [NSString stringWithFormat:@"http://music.163.com/song/media/outer/url?id=%@",self.musicId];
    NSURL *url = [NSURL URLWithString:urlString];
    self.playerItem = [[AVPlayerItem alloc]initWithURL:url];
    [self updatePlayerWithURL:url];
    
    self.player.volume = 1.0f;
    

//-------------------------slider part-----------------------
    self.loadedProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(75, screen.size.height-230, screen.size.width-150, 1)];
    [self.view addSubview:_loadedProgress];
    
    self.playProgress = [[UISlider alloc]initWithFrame:CGRectMake(75, screen.size.height-140, screen.size.width-150 , 31)];
    [self.view addSubview:self.playProgress];
    self.playProgress.value = 0.0f;
    [self.playProgress addTarget:self action:@selector(handleSlider:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, screen.size.height-140, 60, 31)];
    self.leftLabel.font = [UIFont systemFontOfSize:15];
    self.leftLabel.textColor = [UIColor whiteColor];
    self.leftLabel.text = @"0.00";
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen.size.width-70, screen.size.height-140, 60, 31)];
    self.rightLabel.font = [UIFont systemFontOfSize:15];
    self.rightLabel.textColor = [UIColor whiteColor];
    self.rightLabel.text=@"0.00";
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.leftLabel];
    [self.view addSubview:self.rightLabel];
    
    //-----------------top control panel-------------------
    self.topPanel = [[UIView alloc] initWithFrame:CGRectMake(50, screen.size.height-200, screen.size.width-100, 50)];
    [self.view addSubview:_topPanel];
    
    self.likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 9, 32, 32)];
    [self.likeBtn setImage:[UIImage imageNamed:@"喜欢白.png"] forState:UIControlStateNormal];
    [self.likeBtn addTarget:self action:@selector(likeBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.topPanel addSubview:self.likeBtn];
    
    self.downloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(10+32+(screen.size.width-248)/3, 9, 32, 32)];
    [self.downloadBtn setImage:[UIImage imageNamed:@"下载.png"] forState:UIControlStateNormal];
    [self.topPanel addSubview:self.downloadBtn];
    
    self.commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(10+32*2+2*(screen.size.width-248)/3, 9, 32, 32)];
    [self.commentBtn setImage:[UIImage imageNamed:@"评论.png"] forState:UIControlStateNormal];
    [self.topPanel addSubview:self.commentBtn];
    
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(10+32*3+(screen.size.width-248), 9, 32, 32)];
    [self.moreBtn setImage:[UIImage imageNamed:@"更多下.png"] forState:UIControlStateNormal];
    [self.topPanel addSubview:self.moreBtn];
    
    
    //-----------------bottom control panel-------------------
    self.bottomPanel = [[UIView alloc] initWithFrame:CGRectMake(20, screen.size.height-100, screen.size.width-40, 50)];
    [self.view addSubview:_bottomPanel];
    
    self.randomBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 9, 32, 32)];
    [self.randomBtn setImage:[UIImage imageNamed:@"随机播放.png"] forState:UIControlStateNormal];
    [self.bottomPanel addSubview:self.randomBtn];
    
    self.previousBtn = [[UIButton alloc] initWithFrame:CGRectMake(10+32+(screen.size.width-220)/4, 9, 32, 32)];
    [self.previousBtn setImage:[UIImage imageNamed:@"上一首.png"] forState:UIControlStateNormal];
    [self.previousBtn addTarget:self action:@selector(previousBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomPanel addSubview:self.previousBtn];
    
    self.playBtn = [[UIButton alloc] initWithFrame:CGRectMake(10+32*2+(screen.size.width-220)/2, 9, 32, 32)];
    [self.playBtn setImage:[UIImage imageNamed:@"播放.png"] forState:UIControlStateNormal];
    [self.bottomPanel addSubview:self.playBtn];
    [self.playBtn addTarget:self action:@selector(playOrstop:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(10+32*3+3*(screen.size.width-220)/4, 9, 32, 32)];
    [self.nextBtn setImage:[UIImage imageNamed:@"下一首.png"] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomPanel addSubview:self.nextBtn];
    
    self.listBtn = [[UIButton alloc] initWithFrame:CGRectMake(10+32*4+(screen.size.width-220), 9, 32, 32)];
    [self.listBtn setImage:[UIImage imageNamed:@"播放列表.png"] forState:UIControlStateNormal];
    [self.bottomPanel addSubview:self.listBtn];

    
    [self adjustPics];
    
    
    //-------------------添加手势-------------------
    NSInteger directions[4] = {UISwipeGestureRecognizerDirectionRight,UISwipeGestureRecognizerDirectionLeft,UISwipeGestureRecognizerDirectionUp,UISwipeGestureRecognizerDirectionDown};
    for(int i=0;i<4;i++){
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(foundSwiper:)];
        recognizer.direction = directions[i];
        [self.view addGestureRecognizer:recognizer];
        
    }
    self.view.userInteractionEnabled = YES;
}

-(void)playOrstop:(id)sender{
    if (_isPlaying) {
        [self pause];
    } else {
        [self play];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//更新playItem
- (void)updatePlayerWithURL:(NSURL *)url {
    _playerItem = [AVPlayerItem playerItemWithURL:url];
    [_player  replaceCurrentItemWithPlayerItem:_playerItem];
    self.playProgress.value = 0.0f;
    
    NSTimeInterval timeInterval = [self availableDurationRanges]; // 缓冲时间
    CGFloat totalDuration = CMTimeGetSeconds(_playerItem.duration); // 总时间
    [self.loadedProgress setProgress:timeInterval / totalDuration animated:YES];
    
    [self addObserverAndNotification]; // 添加观察者，发布通知
    
}

//添加观察者和发布通知
- (void)addObserverAndNotification {
    [_playerItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew) context:nil]; // 观察status属性， 一共有三种属性
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil]; // 观察缓冲进度
    //[self monitoringPlayback:_playerItem]; // 监听播放
    dispatch_async(dispatch_get_main_queue(), ^{[self monitoringPlayback:_playerItem];});
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)removeObserveAndNotification {
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_player removeTimeObserver:_playTimeObserver];
    _playTimeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//播放
- (void)play {
    _isPlaying = YES;
    [_player play];
    [self.playBtn setImage:[UIImage imageNamed:@"暂停.png"] forState:(UIControlStateNormal)];
    [self playedWithAnimated:YES];
    
    
    // 添加动画
    [self.disc.layer addAnimation:[self getAnimation] forKey:@"imageView-layer"];
    
}

//暂停
- (void)pause {
    _isPlaying = NO;
    [_player pause];
    [self.playBtn setImage:[UIImage imageNamed:@"播放.png"] forState:(UIControlStateNormal)];
    [self pausedWithAnimated:YES];
    [self.disc.layer removeAllAnimations];
    //[self.coverImg.layer removeAllAnimations];
}

//设置歌曲时长
- (void)setMaxDuration:(CGFloat)duration {
    self.playProgress.maximumValue = duration;
    self.rightLabel.text = [NSString convertTime:duration];
}


//响应观察者
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue]; // 获取更改后的状态
        if (status == AVPlayerStatusReadyToPlay) {
            CMTime duration = item.duration; // 获取视频长度
            // 设置视频时间
            [self setMaxDuration:CMTimeGetSeconds(duration)];
            // 播放
            [self play];
        } else if (status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        } else {
            NSLog(@"AVPlayerStatusUnknown");
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDurationRanges]; // 缓冲时间
        CGFloat totalDuration = CMTimeGetSeconds(_playerItem.duration); // 总时间
        [self.loadedProgress setProgress:timeInterval / totalDuration animated:YES];
    }
    
}

// 获取已缓冲进度
- (NSTimeInterval)availableDurationRanges {
    NSArray *loadedTimeRanges = [_playerItem loadedTimeRanges]; // 获取item的缓冲数组
    // discussion Returns an NSArray of NSValues containing CMTimeRanges
    
    // CMTimeRange 结构体 start duration 表示起始位置 和 持续时间
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue]; // 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds; // 计算总缓冲时间 = start + duration
    return result;
}

//更新播放滑块以及左label
- (void)updateVideoSlider:(float)currentTime {
    self.playProgress.value = currentTime;
    self.leftLabel.text = [NSString convertTime:currentTime];
}

//返回按钮
-(void)backBtnPressed:(id)sender{
    NSLog(@"return from songDetail");
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeNum:)]) {
        [self.delegate changeNum:self.shouldMinus];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//分享按钮
-(void)shareBtnPressed:(id)sender{
    NSLog(@"share");
}

-(void)adjustPics{
    if([self.isLike isEqualToString:@"YES"]){
        [self.likeBtn setImage:[UIImage imageNamed:@"喜欢红.png"] forState:UIControlStateNormal];
    }
}

//上一首
-(void)previousBtnPressed{
    self.row--;
    if(self.row<0){
        self.row+=self.songList.count;
    }
    NSString *urlString = [NSString stringWithFormat:@"http://music.163.com/song/media/outer/url?id=%@",[self.songList[self.row] objectForKey:@"MusicId"] ];
    NSURL *url = [NSURL URLWithString:urlString];
    [self removeObserveAndNotification];
    [self pausedWithAnimated:YES];
    [self updatePlayerWithURL:url];
    [self updateInfo];
    [self.coverImg.layer removeAllAnimations];
    [self.coverImg.layer addAnimation:[self getAnimation] forKey:@"imageCover-layer"];
    //[self playedWithAnimated:YES];
}


//下一首
-(void)nextBtnPressed{
    self.row++;
    if(self.row>=self.songList.count){
        self.row-=self.songList.count;
    }
    NSString *urlString = [NSString stringWithFormat:@"http://music.163.com/song/media/outer/url?id=%@",[self.songList[self.row] objectForKey:@"MusicId"] ];
    NSURL *url = [NSURL URLWithString:urlString];
    [self removeObserveAndNotification];
    [self pausedWithAnimated:YES];
    [self updatePlayerWithURL:url];
    [self updateInfo];
    [self.coverImg.layer removeAllAnimations];
    [self.coverImg.layer addAnimation:[self getAnimation] forKey:@"imageCover-layer"];
    //[self playedWithAnimated:YES];
}

//喜欢按钮
-(void)likeBtnPressed:(id)sender{
    self.shouldMinus=@"NO";
    if([self.isLike isEqualToString:@"NO"]){
        [self.likeBtn setImage:[UIImage imageNamed:@"喜欢红.png"] forState:UIControlStateNormal];
        NSLog(@"music ID is %@",self.musicId);
        BmobQuery *changeToLike = [BmobQuery queryWithClassName:@"Music"];
        
        [changeToLike whereKey:@"MusicId" equalTo:self.musicId];
        [changeToLike findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
            BmobObject *object = [array firstObject];
            if (!error) {
                if (object) {
                    BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:object.className objectId:object.objectId];
                    [obj1 setObject:@"YES" forKey:@"isLike"];
                    [obj1 updateInBackground];
                }
            }else{
                //进行错误处理
            }
            
            BmobObject *like = [BmobObject objectWithClassName:@"Like"];
            [like setObject:[object objectForKey:@"MusicAlbum"] forKey:@"MusicAlbum"];
            [like setObject:[object objectForKey:@"MusicAuthor"] forKey:@"MusicAuthor"];
            [like setObject:[object objectForKey:@"MusicSize"] forKey:@"MusicSize"];
            [like setObject:[object objectForKey:@"MusicName"] forKey:@"MusicName"];
            [like setObject:[object objectForKey:@"MusicId"] forKey:@"MusicId"];
            [like setObject:@"YES" forKey:@"isLike"];
            [like saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    //创建成功后会返回objectId，updatedAt，createdAt等信息
                    //创建对象成功，打印对象值
                    NSLog(@"save to like %@",like);
                } else if (error){
                    //发生错误后的动作
                    NSLog(@"%@",error);
                } else {
                    NSLog(@"Unknow error");
                }
            }];
        }];
        
        self.isLike=@"YES";
        
    }else{
        self.shouldMinus=@"YES";
        [self.likeBtn setImage:[UIImage imageNamed:@"喜欢白.png"] forState:UIControlStateNormal];
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"Music"];
        [bquery whereKey:@"MusicId" equalTo:self.musicId];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
            for (BmobObject *obj in array){
                [obj setObject:@"NO" forKey:@"isLike"];
                [obj updateInBackground];
            }
        }];
        self.isLike=@"NO";
        
        //从Like表移除
        BmobQuery *find = [BmobQuery queryWithClassName:@"Like"];
        [find whereKey:@"MusicId" equalTo:self.musicId];
        [find findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
            for (BmobObject *obj in array){
                //[self.tempId initWithFormat:@"%@", [obj objectId]];
                self.tempId=[obj objectId];
                NSLog(@"find is %@",self.tempId);
            }
            
            BmobObject *bmobObject = [BmobObject objectWithoutDataWithClassName:@"Like" objectId:self.tempId];
            [bmobObject deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    //删除成功后的动作
                    NSLog(@"successful delete");
                } else if (error){
                    NSLog(@"%@",error);
                } else {
                    NSLog(@"UnKnow error");
                }
            }];
        }];
    }
    
}

//处理滑块拖动事件
-(void)handleSlider:(id)sender{
    _isSliding = YES;
    [self pause];
    CMTime changedTime = CMTimeMakeWithSeconds(self.playProgress.value, 1.0);
    NSLog(@"%.2f", self.playProgress.value);
    [_playerItem seekToTime:changedTime completionHandler:^(BOOL finished) {
        _isSliding = NO;
        [self updateVideoSlider:self.playProgress.value];
        [self play];
    }];
}

- (void)monitoringPlayback:(AVPlayerItem *)item {
    __weak typeof(self)WeakSelf = self;
    _playTimeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            if (_touchMode != TouchPlayerViewModeHorizontal) {
                // 当前播放秒
                float currentPlayTime = (double)item.currentTime.value/ item.currentTime.timescale;
                // 更新slider, 如果正在滑动则不更新
                if (_isSliding == NO) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [WeakSelf updateVideoSlider:currentPlayTime];
                    });
                }
            } else {
                return;
            }
        }
    ];
    
}


- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

// 播放音乐时，指针恢复，图片旋转
- (void)playedWithAnimated:(BOOL)animated {
    
    if (self.isAnimation) return;
    
    self.isAnimation = YES;
    [self setAnchorPoint:CGPointMake(25.0/97, 25.0/153) forView:self.needle];
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            self.needle.transform = CGAffineTransformIdentity;
        }];
    }else {
        self.needle.transform = CGAffineTransformIdentity;
    }
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animation)];
    
    // 加入到主循环中
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

// 停止音乐时，指针旋转-45°，图片停止旋转
- (void)pausedWithAnimated:(BOOL)animated {
    if (!self.isAnimation) return;
    
    self.isAnimation = NO;
    [self setAnchorPoint:CGPointMake(25.0/97, 25.0/153) forView:self.needle];
    
    if (animated) {
        [UIView animateWithDuration:0.5 animations:^{
            self.needle.transform = CGAffineTransformMakeRotation(-M_PI_4);
        }];
    }else {
        self.needle.transform = CGAffineTransformMakeRotation(-M_PI_4);
    }
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}

// 图片旋转
- (void)animation{
    self.disc.transform = CGAffineTransformRotate(self.disc.transform, M_PI_4 / 100);
}

-(void)dealloc{
    [self removeObserveAndNotification];
}

-(void)updateInfo{
    self.navigationItem.title = [self.songList[self.row] objectForKey:@"MusicName"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer     = [AFJSONRequestSerializer serializer];
    manager.responseSerializer    = [AFHTTPResponseSerializer serializer];
    
    NSString *url = @"http://music.163.com/song";
    [self.coverImg setImage:[UIImage imageNamed:@"defaultCover.jpg"]];
    [manager GET:url parameters:@{@"id": [self.songList[self.row] objectForKey:@"MusicId"]} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        TFHpple *Hpple = [[TFHpple alloc]initWithHTMLData:data];
        NSArray *array =[Hpple searchWithXPathQuery:@"//img"];
        for (TFHppleElement *HppleElement in array) {
            //NSLog(@"%ld",array.count);
            //NSLog((@"测试2的目的标签内容:-- %@"), [HppleElement objectForKey:@"src"]);
            self.imageUrl = [HppleElement objectForKey:@"src"];
            NSLog(@"from localVC %@",self.imageUrl);
        }
        [self.coverImg sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]
                         placeholderImage:[UIImage imageNamed:@"defaultCover.jpg"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求切换封面失败");
        
    }];
}

-(CABasicAnimation*)getAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.removedOnCompletion = NO;
    // 设定动画选项
    animation.duration    = 20.0;
    animation.repeatCount = HUGE_VALF;
    
    // 设定旋转角度
    animation.fromValue   = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue     = [NSNumber numberWithFloat:2*M_PI];  // 终止角度
    return animation;
}

//播放结束
- (void)playbackFinished:(NSNotification *)notification {
    NSLog(@"Audio&Video播放完成");
    _playerItem = [notification object];
    // 是否无限循环
    [self nextBtnPressed];
}


-(void)foundSwiper:(UISwipeGestureRecognizer*)sender{
    NSLog(@"direction = &li",sender.direction);
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            [self nextBtnPressed];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self previousBtnPressed];
        default:
            break;
    }
    
}

@end
