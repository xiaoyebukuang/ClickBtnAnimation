//
//  XYCustomeSegmentControlView.h
//  ClickBtnAnimation
//
//  Created by cyp on 15/12/29.
//  Copyright (c) 2015年 cyp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonOnClickBlock)(NSInteger tag, NSString * title);

@interface XYCustomeSegmentControlView : UIView

/**
 *  标题数组
 */
@property (nonatomic, strong) NSArray *titles;
/**
 *  标题的常规颜色，默认为黑色
 */
@property (nonatomic, strong) UIColor *titlesCustomeColor;
/**
 *  标题高亮颜色，默认为白色
 */
@property (nonatomic, strong) UIColor *titlesHeightLightColor;
/**
 *  高亮时的颜色，默认为红色
 */
@property (nonatomic, strong) UIColor *backgroundHeightLightColor;
/**
 * 标题的字号，默认为12
 */
@property (nonatomic, strong) UIFont *titlesFont;
/**
 * 运动时间，默认为0.5
 */
@property (nonatomic, assign) CGFloat duration;


/**
 *  初始化以及点击按钮的回调
 *
 *  @param frame     frame
 *  @param clickBook 点击按钮的回调
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame withClickBlock:(ButtonOnClickBlock)clickBook;

@end
