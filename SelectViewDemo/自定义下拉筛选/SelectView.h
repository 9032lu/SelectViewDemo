//
//  SelectView.h
//  SelectViewDemo
//
//  Created by LanSha on 2017/8/8.
//  Copyright © 2017年 LanSha. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectView,LzdItemModel;

typedef NS_ENUM(NSInteger,ButtonClickType){
    ButtonClickTypeNormal = 0,
    ButtonClickTypeUp = 1,
    ButtonClickTypeDown = 2,
};

#pragma mark 代理

//重置 确定按钮
@protocol  LZDBottomViewDelegate <NSObject>

/**
 按钮的点击事件
 @param btnTag 0 重置 1 确定
 */
-(void)LZDBottomViewButtonClick:(NSInteger)btnTag;
@end

@protocol NY_SelectViewDelegate <NSObject>

@optional
//选中最上方的按钮的点击事件
- (void)selectTopButton:(SelectView *)selectView withIndex:(NSInteger)index withButtonType:(ButtonClickType )type;
//选中分类中按钮的点击事件
- (void)selectItme:(SelectView *)selectView withIndex:(NSInteger)index;
//确定按钮
-(void)LZdBottomSureBtnClick:(SelectView*)selectView withTopIndex:(NSInteger)topIndex WithDataA:(NSArray*)dataA;

@end



@interface SelectView : UIView

@property (nonatomic, weak) id<NY_SelectViewDelegate>delegate;

//设置可选项数组
@property (nonatomic, copy) NSArray *selectItmeArr;
/**
 <#Description#>
 */
@property (nonatomic,assign) NSInteger defasultSelectIndex;
/**
是否单选选
 */
@property (nonatomic,assign) BOOL isSingleSelect;
/**
 <#Description#>
 */
@property (nonatomic,assign) CGFloat cloumCount;

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray*)titleArray;

@end



@interface LZDBottomView : UIView

/**
 <#Description#>
 */
@property (nonatomic,weak) id<LZDBottomViewDelegate> delegata;
/**
 重置按钮
 */
@property (nonatomic,strong) UIButton *reSetButton;
/**
 取消按钮
 */
@property (nonatomic,strong) UIButton *sureButtom;


@end


@interface LzdItemModel : NSObject
/**
 <#Description#>
 */
@property (nonatomic,copy) NSString *name;
/**
 <#Description#>
 */
@property (nonatomic,copy) NSString *count;


@property (nonatomic,assign) BOOL selected;
@end
