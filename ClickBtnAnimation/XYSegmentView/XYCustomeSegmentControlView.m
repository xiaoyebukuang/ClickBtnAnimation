//
//  XYCustomeSegmentControlView.m
//  ClickBtnAnimation
//
//  Created by cyp on 15/12/29.
//  Copyright (c) 2015年 cyp. All rights reserved.
//

#import "XYCustomeSegmentControlView.h"
#import "UIView+Frame.h"


#define BTN_TAG 100
@interface XYCustomeSegmentControlView()
{
    /**
     *  宽度
     */
    CGFloat _width;
    /**
     *  选中的按钮
     */
    NSInteger _selectIndex;
}
/**
 *  点击block
 */
@property (nonatomic ,copy) ButtonOnClickBlock clickBlock;
/**
 *  移动的view
 */
@property (nonatomic ,strong) UIView* removeView;

/**
 *  红色背景view
 */
@property (nonatomic ,strong) UIView* redView;
/**
 *  点击按钮view
 */
@property (nonatomic ,strong) UIView* titleRemoveView;
@end

@implementation XYCustomeSegmentControlView

- (instancetype)initWithFrame:(CGRect)frame withClickBlock:(ButtonOnClickBlock)clickBook{
    self = [super initWithFrame:frame];
    if (self) {
        self.titlesCustomeColor = [UIColor blackColor];
        self.titlesHeightLightColor = [UIColor yellowColor];
        self.titlesFont = [UIFont systemFontOfSize:12];
        self.backgroundHeightLightColor = [UIColor redColor];
        self.duration = 0.4;
        _selectIndex = 0;
        self.backgroundColor = [UIColor purpleColor];
        self.clickBlock = clickBook;
    }
    return self;
}



- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    _width = self.width/titles.count;
    for (int i = 0; i < titles.count; i ++) {
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(i*_width, 0, _width, self.height)];
        label.text = titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = self.titlesCustomeColor;
        [self addSubview:label];
    }
    //红色背景view
    self.removeView = [[UIView alloc]initWithFrame:CGRectMake(_selectIndex*_width,0,_width,self.height)];
    self.removeView.layer.masksToBounds = YES;
    self.removeView.layer.cornerRadius = self.removeView.height/2;
    self.removeView.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.removeView];
    //红色移动view
    self.redView = [[UIView alloc]initWithFrame:self.removeView.bounds];
    self.redView.backgroundColor = self.backgroundHeightLightColor;
    [self.removeView addSubview:self.redView];
    //点击状态移动view
    self.titleRemoveView = [[UIView alloc]initWithFrame:self.bounds];
    [self.removeView addSubview:self.titleRemoveView];
    
    UIView* clickView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:clickView];
    
    for (int i = 0; i < titles.count; i ++) {
        //高亮label
        UILabel* heightLightlabel = [[UILabel alloc]initWithFrame:CGRectMake(i*_width, 0, _width, self.height)];
        heightLightlabel.text = titles[i];
        heightLightlabel.textAlignment = NSTextAlignmentCenter;
        heightLightlabel.textColor = self.titlesHeightLightColor;
        [self.titleRemoveView addSubview:heightLightlabel];
        //点击按钮
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = heightLightlabel.frame;
        btn.tag = BTN_TAG + i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [clickView addSubview:btn];
    }
}
- (void)clickBtn:(UIButton *)btn{
    if (_selectIndex == btn.tag - BTN_TAG) {
        return;
    }
    _selectIndex = btn.tag - BTN_TAG;
    [UIView animateWithDuration:self.duration animations:^{
        self.removeView.left = _selectIndex*_width;
        self.titleRemoveView.left = - _selectIndex*_width;
    } completion:^(BOOL finished) {
        [self shakeAnimationForView:self.redView];
    }];
    if (self.clickBlock) {
        self.clickBlock(_selectIndex,self.titles[_selectIndex]);
    }
}
/**
 *  抖动效果
 *
 *  @param view 要抖动的view
 */
- (void)shakeAnimationForView:(UIView *) view {
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x + 5, position.y);
    CGPoint y = CGPointMake(position.x - 5, position.y);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:.06];
    [animation setRepeatCount:3];
    [viewLayer addAnimation:animation forKey:nil];
}

@end
