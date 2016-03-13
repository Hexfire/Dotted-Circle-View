//
//  ViewController.m
//  Dotted Circle View
//
//  Created by Hamish Knight on 12/03/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    DottedCircleView* v = [[DottedCircleView alloc] init];
    v.frame = self.view.frame;
    v.dotColor = [UIColor redColor];
    v.dotSpacing = 40.0;
    v.dotDiameter = 20.0;
    [self.view addSubview:v];
    
    UIImageView* i = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, v.frame.size.width*1.5, v.frame.size.width)];
    i.center = v.center;
    i.image = [UIImage imageNamed:@"cat.jpg"];
    i.contentMode = UIViewContentModeScaleAspectFit;
    [v addSubview:i];
}


// legacy code
-(void) addCircleDotLayer {
    // your dot diameter.
    CGFloat dotDiameter = 10.0;
    
    // your 'expected' dot spacing. we'll try to get as closer value to this as possible.
    CGFloat expDotSpacing = 20.0;
    
    // the size of your view
    CGSize s = self.view.frame.size;
    
    // the radius of your circle, half the width or height (whichever is smaller) with the dot radius subtracted to account for stroking
    CGFloat radius = (s.width < s.height) ? s.width*0.5-dotDiameter*0.5 : s.height*0.5-dotDiameter*0.5;
    
    // the circumference of your circle
    CGFloat circum = M_PI*radius*2.0;
    
    // the number of dots to draw as given by the circumference divided by the diameter of the dot plus the expected dot spacing.
    NSUInteger numberOfDots = round(circum/(dotDiameter+expDotSpacing));
    
    // the calculated dot spacing, as given by the circumference divided by the number of dots, minus the dot diameter.
    CGFloat dotSpacing = (circum/numberOfDots)-dotDiameter;
    
    // your shape layer
    CAShapeLayer* l = [CAShapeLayer layer];
    l.frame = (CGRect){0, 0, s.width, s.height};
    
    // set to the diameter of each dot
    l.lineWidth = dotDiameter;
    
    // your stroke color
    l.strokeColor = [UIColor blackColor].CGColor;
    
    // the circle path - given the center of the layer as the center and starting at the top of the arc.
    UIBezierPath* p = [UIBezierPath bezierPathWithArcCenter:(CGPoint){s.width*0.5, s.height*0.5} radius:radius startAngle:-M_PI*0.5 endAngle:M_PI*1.5 clockwise:YES];
    l.path = p.CGPath;
    
    // prevent that layer from filling the area that the path occupies
    l.fillColor = [UIColor clearColor].CGColor;
    
    // round shape for your stroke
    l.lineCap = kCALineCapRound;
    
    // 0 length for the filled segment (radius calculated from the line width), dot diameter plus the dot spacing for the un-filled section
    l.lineDashPattern = @[@(0), @(dotSpacing+dotDiameter)];
    
    [self.view.layer addSublayer:l];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
