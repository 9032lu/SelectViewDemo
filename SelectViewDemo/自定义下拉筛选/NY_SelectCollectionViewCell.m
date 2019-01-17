//
//  NY_SelectCollectionViewCell.m
//  中安生态商城
//
//  Created by LanSha on 2017/7/25.
//  Copyright © 2017年 王鑫年. All rights reserved.
//

#import "NY_SelectCollectionViewCell.h"
#define KUnSelectBorderColor    [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]
#define KButtonColor            [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
//#define MAINCOLOR                   RGBA(0, 142, 236, 1)

@implementation NY_SelectCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderColor = KUnSelectBorderColor.CGColor;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.cornerRadius = 2;
    self.Btn.titleLabel.font = [UIFont systemFontOfSize:13*FIT_WIDTH];
    self.Btn.backgroundColor = [UIColor clearColor];
    self.Btn.userInteractionEnabled = NO;
    self.selectCell = NO;
    [self.Btn setTitleColor:KButtonColor forState:UIControlStateNormal];
    // Initialization code
}
- (void)setSelectCell:(BOOL)selectCell{
    if (selectCell) {
        self.contentView.layer.borderColor = MAINCOLOR.CGColor;
        self.contentView.backgroundColor = MAINCOLOR;
    }else{
        self.contentView.layer.borderColor = KUnSelectBorderColor.CGColor;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

@end
