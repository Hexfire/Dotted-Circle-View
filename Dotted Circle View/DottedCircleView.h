//
//  DottedCircleView.h
//  Dotted Circle View
//
//  Created by Hamish Knight on 12/03/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DottedCircleView : UIView

/// The diameter of each dot.
@property (nonatomic) CGFloat dotDiameter;

/// The 'expected' spacing between each dot - will be approximated to give an integral number of dots.
@property (nonatomic) CGFloat dotSpacing;

/// The color of each dot.
@property (nonatomic) UIColor* dotColor;

@end
