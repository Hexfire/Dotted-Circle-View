//
//  DottedCircleView.m
//  Dotted Circle View
//
//  Created by Hamish Knight on 12/03/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

#import "DottedCircleView.h"

@implementation DottedCircleView {
    CAShapeLayer* circleDotLayer;
    CAShapeLayer* maskLayer;
}

-(instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.opaque = NO;
        self.layer.masksToBounds = YES;
        
        maskLayer = [CAShapeLayer layer];
        maskLayer.fillColor = [UIColor whiteColor].CGColor;
        self.layer.mask = maskLayer;
        
        circleDotLayer = [CAShapeLayer layer];
        circleDotLayer.fillColor = [UIColor clearColor].CGColor;
        circleDotLayer.zPosition = 99999;
        circleDotLayer.lineCap = kCALineCapRound;
        [self.layer addSublayer:circleDotLayer];
        
        self.dotColor = [UIColor blackColor];
        _dotDiameter = 10.0;
        _dotSpacing = 20.0;
        [self updateDotLayer];
        
    }
    return self;
}

-(void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self updateDotLayer];
}

-(void) updateDotLayer {
    
    // the radius of your circle, half the width or height (whichever is smaller) with the dot radius subtracted to account for stroking
    CGFloat radius = (self.frame.size.width < self.frame.size.height) ? self.frame.size.width*0.5-_dotDiameter*0.5 : self.frame.size.height*0.5-_dotDiameter*0.5;
    
    // the circumference of your circle
    CGFloat circum = M_PI*radius*2.0;
    
    // the number of dots to draw as given by the circumference divided by the diameter of the dot plus the expected dot spacing.
    NSUInteger numberOfDots = round(circum/(_dotDiameter+_dotSpacing));
    
    // the calculated dot spacing, as given by the circumference divided by the number of dots, minus the dot diameter.
    CGFloat dotSpacing = (circum/numberOfDots)-_dotDiameter;
    
    // update layer frame
    circleDotLayer.frame = (CGRect){CGPointZero, self.frame.size};
    
    // set to the diameter of each dot
    circleDotLayer.lineWidth = _dotDiameter;
    
    // the circle path - given the center of the layer as the center and starting at the top of the arc.
    UIBezierPath* strokePath = [UIBezierPath bezierPathWithArcCenter:(CGPoint){self.frame.size.width*0.5, self.frame.size.height*0.5} radius:radius startAngle:-M_PI*0.5 endAngle:M_PI*1.5 clockwise:YES];
    
    circleDotLayer.path = strokePath.CGPath;
    
    // 0 length for the filled segment (radius calculated from the line width), dot diameter plus the dot spacing for the un-filled section
    circleDotLayer.lineDashPattern = @[@(0), @(dotSpacing+_dotDiameter)];
    
    // the outline path - used the mask the view's layer.
    UIBezierPath* outlinePath = [UIBezierPath bezierPathWithArcCenter:(CGPoint){self.frame.size.width*0.5, self.frame.size.height*0.5} radius:radius+_dotDiameter*0.5 startAngle:-M_PI*0.5 endAngle:M_PI*1.5 clockwise:YES];
    
    maskLayer.path = outlinePath.CGPath;
    
}

-(void) setDotDiameter:(CGFloat)dotDiameter {
    _dotDiameter = dotDiameter;
    [self updateDotLayer];
}

-(void) setDotSpacing:(CGFloat)dotSpacing {
    _dotSpacing = dotSpacing;
    [self updateDotLayer];
}

-(void) setDotColor:(UIColor *)dotColor {
    _dotColor = dotColor;
    circleDotLayer.strokeColor = dotColor.CGColor;
}



@end
