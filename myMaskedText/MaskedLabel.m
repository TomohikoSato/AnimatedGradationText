//
//  MaskedLabel.m
//  myMaskedText
//
//  Created by 佐藤　智彦 on 3/2/15.
//  Copyright (c) 2015 佐藤　智彦. All rights reserved.
//

#import "MaskedLabel.h"

@implementation MaskedLabel {
    CAGradientLayer *_gradientLayer;
    CATextLayer *_maskLayer;
};

- (void) awakeFromNib {
    [super awakeFromNib];
    [self p_initGradientLayer];
    [self p_initMaskLayer];
    self.textColor = [UIColor clearColor]; // textlayerのtextをみせるため
}

- (void) p_initGradientLayer {
    // setup
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.startPoint = (CGPoint){0.0, 0.5};
    _gradientLayer.endPoint = (CGPoint){1.0, 0.5};
    _gradientLayer.colors = @[
            (id)UIColor.blackColor.CGColor,
            (id)UIColor.whiteColor.CGColor,
            (id)UIColor.blackColor.CGColor
    ];
    _gradientLayer.locations = @[@0.0, @0.5, @1.0];
    _gradientLayer.frame = CGRectInset(self.bounds, - self.bounds.size.width, 0);
    [self.layer addSublayer:_gradientLayer];

    // aniamte
    CABasicAnimation *gradientAnimation= [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientAnimation.fromValue = @[@0.0, @0.0, @0.25];
    gradientAnimation.toValue = @[@0.75, @1.0, @1.0];
    gradientAnimation.duration = 2.0;
    gradientAnimation.repeatCount = HUGE_VALF;
    [_gradientLayer addAnimation: gradientAnimation forKey:nil];
}

- (void) p_initMaskLayer {
    _maskLayer = [CATextLayer layer];
    _maskLayer.frame = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height); //gradientLayerからの相対座標
    _maskLayer.string = self.text;
    _maskLayer.font = (__bridge CFTypeRef)self.font;
    _maskLayer.fontSize = self.font.pointSize;
    _maskLayer.alignmentMode = kCAAlignmentCenter;
    _maskLayer.contentsScale = [[UIScreen mainScreen] scale];
    _gradientLayer.mask = _maskLayer;
}

@end
