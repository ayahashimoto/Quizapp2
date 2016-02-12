//
//  ViewController.m
//  QuizApp
//
//  Created by 橋本 遥 on 2016/01/29.
//  Copyright © 2016年 aya. All rights reserved.
//

#import "ViewController.h"
SystemSoundID sound_1;
SystemSoundID sound_2;

@interface ViewController ()


@end

@implementation ViewController



// @storyboardにて
// 背景画像の表示
// ボタンの表示
// 正解・不正解ラベルの表示
// クイズ本文枠の表示 してます *mondai
NSInteger countNumber;
NSInteger questionNumber;


- (void)viewDidLoad {
    [super viewDidLoad];
    countNumber = 0; // 正解数カウンターに0代入
    questionNumber = 1; //問題数カウントに0代入
    [self mondai1]; //問題文を読み込む
    [self.seikai setHidden:YES];
    [self.huseikai setHidden:YES];
    [self.seitou setHidden:YES];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"coin01" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &sound_1);
    
    
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"pickup02" ofType:@"mp3"];
    NSURL *url2 = [NSURL fileURLWithPath:path2];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url2), &sound_2);
    
}

// Do any additional setup after loading the view, typically from a nib.


-(void)mondai1{
    if (questionNumber==1) {
        self.mondai.text = @"イルカは魚類である";// 問題文1を表示します（答えは✕）
    }
    if (questionNumber==2) {
        self.mondai.text = @"カエルは両生類である";// 問題文2を表示します（答えは◯）
    }
    if (questionNumber==3) {
        self.mondai.text = @"アザラシは魚類である";// 問題文3を表示します（答えは✕）
    }
    if (questionNumber==4) {
        self.mondai.text = @"亀は両生類である";// 問題文4を表示します（答えは◯）
    }
    if (questionNumber==5) {
        self.mondai.text = @"ペンギンは鳥類である";// 問題文5を表示します（答えは◯）
    }
}



-(void)seitoubox{
    NSInteger i = countNumber * 20;
    NSLog(@"正答率は%ldパーセントでした",(long)i);
    self.seitou.text = ([NSString stringWithFormat:@"正答率は%ldパーセントでした",(long)i]);
}



- (void)seikaiaction { // 正解の時は「正解」画像を表示する　正解数++　★storyboardにしていく
    AudioServicesPlaySystemSound(sound_1);
    
    self.resultimageview.image = [UIImage imageNamed:@"l_s.png"];
    self.resultimageview.hidden = NO;
    // 3秒後に処理を実行
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
    
    dispatch_after(time, dispatch_get_main_queue(), ^{
     self.resultimageview.hidden = YES;   // do something.
    });
    
    
//    UIImageView *animView2 = [[UIImageView alloc] initWithFrame:CGRectMake(250, 120, 200, 200)];
    //animView2.image = [UIImage imageNamed:@"l_s.png"];
//    [self.view addSubview:animView2];
//    [UIView animateWithDuration:0.1f delay:0.5f
//                        options:UIViewAnimationOptionCurveEaseInOut animations:^ {
//                            animView2.frame = CGRectMake(250, 600, 200, 200);
//                        } completion:nil];
    countNumber ++;
    [self mondai1];
}


- (void)huseikaiaction { // 不正解の時は「不正解」画像を表示する　正解数変動なし　★storyboardにしていく
    AudioServicesPlaySystemSound(sound_2);
    
    self.resultimageview.image = [UIImage imageNamed:@"l_h.png"];
    self.resultimageview.hidden = NO;
    // 3秒後に処理を実行
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
    
    dispatch_after(time, dispatch_get_main_queue(), ^{
        self.resultimageview.hidden = YES;   // do something.
    });

    
//    UIImageView *animView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 120, 200, 200)];
//    animView.image = [UIImage imageNamed:@"l_h.png"];
//    [self.view addSubview:animView];
//    [UIView animateWithDuration:0.1f delay:0.5f
//                        options:UIViewAnimationOptionCurveEaseInOut animations:^ {
//                            animView.frame = CGRectMake(250, 600, 200, 200);
//                        } completion:nil];
    [self mondai1];
    
}


-(IBAction)maru:(id)sender{ //◯ボタンを押した時
    if (questionNumber==1) {  //もし問題番号が1なら（答えは✕）
        questionNumber++; //問題数カウント+1
        
        [self huseikaiaction];  //「不正解」画像を表示
    }
    else if (questionNumber==2) {  //もし問題番号が2なら（答えは◯）
        questionNumber++; //問題数カウント+1
        [self seikaiaction];  //「正解」画像を表示
    }
    else if (questionNumber==3) {  //もし問題番号が3なら（答えは✕）
        questionNumber++; //問題数カウント+1
        [self huseikaiaction];  //「不正解」画像を表示
    }
    else if (questionNumber==4) {  //もし問題番号が4なら（答えは◯）
        questionNumber++; //問題数カウント+1
        [self seikaiaction];  //「正解」画像を表示
    }
    else if (questionNumber==5) {  //もし問題番号が4なら（答えは◯）
        [self seikaiaction];  //「正解」画像を表示
        [self.bg_q setHidden:YES];
        [self.mondai setHidden:YES];
        [self.bg_r setHidden:NO];
        [self.seitou setHidden:NO];
        [self seitoubox];
        self.view.userInteractionEnabled = NO;
        
    }
}


-(IBAction)batsu:(id)sender{//✕ボタンを押した時
    if (questionNumber==1) {  //もし問題番号が1なら（答えは✕）
        questionNumber++; //問題数カウント+1
        [self seikaiaction];  //「正解」画像を表示
    }
    
    else if (questionNumber==2) {  //もし問題番号が2なら（答えは◯）
        questionNumber++; //問題数カウント+1
        [self huseikaiaction];  //「不正解」画像を表示
    }
    else if (questionNumber==3) {  //もし問題番号が3なら（答えは✕）
        questionNumber++; //問題数カウント+1
        [self seikaiaction];  //「正解」画像を表示
    }
    else if (questionNumber==4) {  //もし問題番号が4なら（答えは◯）
        questionNumber++; //問題数カウント+1
        [self huseikaiaction];  //「不正解」画像を表示
    }
    else if (questionNumber==5) {  //もし問題番号が4なら（答えは◯）
        [self huseikaiaction];  //「不正解」画像を表示
        [self.bg_q setHidden:YES];
        [self.mondai setHidden:YES];
        [self.bg_r setHidden:NO];
        [self.seitou setHidden:NO];
        [self seitoubox];
        self.view.userInteractionEnabled = NO;
        
    }
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
