//
//  NY_SelectCollectionViewCell.h
//  中安生态商城
//
//  Created by LanSha on 2017/7/25.
//  Copyright © 2017年 王鑫年. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef RGBA
#define RGBA(r,g,b,a)           \
[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#endif
// 主色调
#define MAINCOLOR                   RGBA(255, 108, 0, 1)
#define FIT_WIDTH [UIScreen mainScreen].bounds.size.width/375

@interface NY_SelectCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *Btn;
@property (nonatomic, assign) BOOL      selectCell;

@end
