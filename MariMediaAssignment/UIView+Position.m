//
//  UIView+Position.m
//  payou
//
//  Created by Nissim Pardo on 12/27/13.
//  Copyright (c) 2013 Nissim Pardo. All rights reserved.
//

#import "UIView+Position.h"

@implementation UIView (Position)
@dynamic xPos, hiSize, yPos, wSize;

- (void)setXPos:(CGFloat)xPos {
    CGRect temp = self.frame;
    temp.origin.x = xPos;
    self.frame = temp;
}

- (void)setYPos:(CGFloat)yPos {
    CGRect temp = self.frame;
    temp.origin.y = yPos;
    self.frame = temp;
}

- (void)setHiSize:(CGFloat)hSize {
    CGRect temp = self.frame;
    temp.size.height = hSize;
    self.frame = temp;
}

- (void)setWSize:(CGFloat)wSize {
    CGRect temp = self.frame;
    temp.size.width = wSize;
    self.frame = temp;
}
@end
