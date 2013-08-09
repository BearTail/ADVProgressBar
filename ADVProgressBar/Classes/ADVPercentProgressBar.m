//
//  ADVPercentProgressBar.m
//  ADVProgressBar
//
//
/*
 The MIT License
 
 Original work Copyright (c) 2011 Tope Abayomi
 http://www.appdesignvault.com/
 
 Modified work Copyright (c) 2013 Corrado Ubezio
 https://github.com/corerd/
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */


#import "ADVPercentProgressBar.h"

#import <QuartzCore/QuartzCore.h>




#define PERCENT_VIEW_WIDTH      32.0f
#define PERCENT_VIEW_MIN_HEIGHT 14.0f
#define TOP_PADDING              7.0f
#define LEFT_PADDING             5.0f
#define RIGHT_PADDING            3.0f

@implementation ADVPercentProgressBar
{
    UIView* percentView;
    UIImageView *bgImageView;
    UIImageView *progressImageView;
    UIImage *progressFillImage;
    
    BOOL customViewFromNIB;

}


@synthesize progress;
@synthesize progressBarColor;


// Override initWithFrame: if you add the view programmatically.
- (id)initWithFrame:(CGRect)frame andProgressBarColor:(ADVProgressBarColor)barColor
{
    
    if (self = [super initWithFrame:frame])
    {
        customViewFromNIB = NO;
        [self ADVProgressBarDraw:frame withProgressBarColor:barColor];
    }
    
    return self;
}

// Override initWithCoder: if you're loading it from a nib or storyboard.
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        customViewFromNIB = YES;
        [self ADVProgressBarDraw:self.frame
            withProgressBarColor:ADVProgressBarBlue1];
    }
    
    return self;
}

// Override layoutSubviews: it gets called whenever the frame of the view changes.
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (customViewFromNIB != YES) {
        return;
    }
    [self progressImageDraw];
}

- (void)setProgress:(CGFloat)theProgress
{
    if (self.progress == theProgress) {
        return;
    }
    
    // check range and pin to its limits if required
    if (theProgress < self.minProgressValue) {
        theProgress = self.minProgressValue;
    }
    if (theProgress > self.maxProgressValue) {
        theProgress = self.maxProgressValue;
    }
    
    progress = theProgress;
    
    [self progressImageDraw];
}

- (void)setProgressBarColor:(ADVProgressBarColor)theColor
{
    UIView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	
	UIColor *barColor;
	
	
	switch (theColor) {
		case ADVProgressBarRed:
			barColor = [self colorWithHex:@"E95151" alpha:1.0];
			break;
			
		case ADVProgressBarOrange1:
			barColor = [self colorWithHex:@"E27A50" alpha:1.0f];
			break;
			
		case ADVProgressBarOrange2:
			barColor = [self colorWithHex:@"E59A52" alpha:1.0f];
			break;
			
		case ADVProgressBarYellow1:
			barColor = [self colorWithHex:@"E5C053" alpha:1.0f];
			break;
			
		case ADVProgressBarYellow2:
			barColor = [self colorWithHex:@"E4DF56" alpha:1.0f];
			break;
			
		case ADVProgressBarGreen1:
			barColor = [self colorWithHex:@"AACF59" alpha:1.0f];
			break;
			
		case ADVProgressBarGreen2:
			barColor = [self colorWithHex:@"75BC52" alpha:1.0f];
			break;
			
		case ADVProgressBarBlue1:
			barColor = [self colorWithHex:@"72C3B0" alpha:1.0f];
			break;
			
		case ADVProgressBarBlue2:
			barColor = [self colorWithHex:@"6AC4D4" alpha:1.0f];
			break;
			
		case ADVProgressBarBlue3:
			barColor = [self colorWithHex:@"E59A52" alpha:1.0f];
			break;
			
		case ADVProgressBarBlue4:
			barColor = [self colorWithHex:@"67A2C9" alpha:1.0f];
			break;
			
		case ADVProgressBarBlue5:
			barColor = [self colorWithHex:@"6373B6" alpha:1.0f];
			break;
			
		case ADVProgressBarPurple1:
			barColor = [self colorWithHex:@"6F66AB" alpha:1.0f];
			break;
			
		case ADVProgressBarPurple2:
			barColor = [self colorWithHex:@"9068A9" alpha:1.0f];
			break;
			
		case ADVProgressBarPurple3:
			barColor = [self colorWithHex:@"C366A3" alpha:1.0f];
			break;
			
		case ADVProgressBarPurple4:
			barColor = [self colorWithHex:@"C96670" alpha:1.0f];
			break;
			
		default:
			barColor = [self colorWithHex:@"E95151" alpha:1.0];
			break;
	}

	
	view.backgroundColor = barColor;
	
	progressFillImage = [self imageFromView:view];
}

- (void)ADVProgressBarDraw:(CGRect)frame withProgressBarColor:(ADVProgressBarColor)barColor
{
//    if ( (frame.size.width - LEFT_PADDING - RIGHT_PADDING) < PERCENT_VIEW_WIDTH ) {
//        NSLog(@"ADVProgressBarDraw: Frame width is too small to draw PercentView");
//        return;
//    }
    
    self.progressBarColor = barColor;
    
    bgImageView = [[UIImageView alloc] initWithFrame:
                   CGRectMake(
                              0,
                              0,
                              frame.size.width,
                              frame.size.height )
                   ];
    
    [bgImageView setImage:[UIImage imageNamed:@"progress-track.png"]];
    
    //[self addSubview:bgImageView];
    
    progressImageView = [[UIImageView alloc] initWithFrame:
                         CGRectMake(
                                    1,
                                    0,
                                    0,
                                    frame.size.height )
                         ];
    
    [self addSubview:progressImageView];

    CGSize bgImageScale;
    if (customViewFromNIB == YES) {
        bgImageScale = [self getScale:bgImageView.image.size
                            fitInSize:bgImageView.frame.size
                            withMode:self.contentMode
                        ];
    }
    else {
        bgImageScale = [self getScale:bgImageView.frame.size
                            fitInSize:bgImageView.image.size
                            withMode:self.contentMode
                        ];
    }
    
    CGFloat topPadding = TOP_PADDING;
    if (bgImageScale.height > 1) {
        topPadding *= bgImageScale.height;
    }

    CGFloat bgImageHeight = bgImageView.frame.size.height;
    if (bgImageScale.height < 1) {
        bgImageHeight -= (bgImageView.frame.size.height - topPadding) * bgImageScale.height;
    }

    CGFloat centerY = bgImageView.center.y;
    CGFloat percentViewY = topPadding + centerY - bgImageHeight / 2;
    CGFloat percentViewHeight = (centerY - percentViewY)*2;

    if (percentViewHeight < PERCENT_VIEW_MIN_HEIGHT) {
        NSLog(@"ADVProgressBarDraw: Frame heigh is too small to draw PercentView");
        return;
    }
    
    percentView = [[UIView alloc] initWithFrame:
                   CGRectMake(
                              LEFT_PADDING,
                              percentViewY,
                              PERCENT_VIEW_WIDTH,
                              percentViewHeight )
                   ];
    
    UIImageView* percentImageView = [[UIImageView alloc] initWithFrame:
                                     CGRectMake(
                                                0,
                                                0,
                                                PERCENT_VIEW_WIDTH,
                                                percentViewHeight )
                                     ];
    
    //[percentImageView setImage:[UIImage imageNamed:@"progress-count.png"]];
    
    UILabel* percentLabel = [[UILabel alloc] initWithFrame:
                             CGRectMake(
                                        0,
                                        0,
                                        PERCENT_VIEW_WIDTH,
                                        percentViewHeight )
                             ];
    
    [percentLabel setTag:1];
    [percentLabel setText:@"0"];
    [percentLabel setBackgroundColor:[UIColor clearColor]];
    [percentLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [percentLabel setTextAlignment:UITextAlignmentCenter];
    [percentLabel setAdjustsFontSizeToFitWidth:YES];
    
    [percentView addSubview:percentImageView];
    [percentView addSubview:percentLabel];
    
    [self addSubview:percentView];

    self.showPercent = YES;
    self.minProgressValue = 0.0f;
    self.maxProgressValue = 1.0f;
    self.progress = 0.0f;
}

- (void)progressImageDraw
{
    BOOL showPercent;
    if (self.maxProgressValue <= 1.0 || self.maxProgressValue >= 1000.0) {
        showPercent = YES;
    }
    else {
        showPercent = self.showPercent;
    }
    
    CGFloat percentProgress = (progress - self.minProgressValue) /
    (self.maxProgressValue - self.minProgressValue);
    
    progressImageView.image = progressFillImage;
    
    CGRect frame = progressImageView.frame;
    
    frame.origin.x = 2;
    frame.origin.y = 2;
    frame.size.height = bgImageView.frame.size.height - 4;
    
    frame.size.width = (bgImageView.frame.size.width - 4) * percentProgress;
    
    progressImageView.frame = frame;
    
    CGRect percentFrame = percentView.frame;
    
    float percentViewWidth = percentView.frame.size.width;
    float leftEdge = (progressImageView.frame.size.width - percentViewWidth) - RIGHT_PADDING;
    
    percentFrame.origin.x = (leftEdge < LEFT_PADDING) ? LEFT_PADDING : leftEdge;
    percentView.frame = percentFrame;
    
    UILabel* percentLabel = (UILabel*)[percentView viewWithTag:1];
    if (showPercent == YES) {
        // show percent
        if (percentProgress > 0) {
            [percentLabel setText:
             [NSString  stringWithFormat:@"%d%%", (int)(percentProgress*100)]];
        }
        else {
            [percentLabel setText:@"0"];
        }
    }
    else {
        // show integral
        [percentLabel setText:[NSString  stringWithFormat:@"%d", (int)progress]];
    }
	
	if (leftEdge < LEFT_PADDING) {
		percentLabel.textColor = [UIColor colorWithWhite:0.3f alpha:1.0];
	} else {
		percentLabel.textColor = [UIColor whiteColor];
	}
}

// Thanks to Cyrille
// http://stackoverflow.com/questions/6856879/iphone-getting-the-size-of-an-image-after-aspectft
- (CGSize)getScale:(CGSize)originalSize fitInSize:(CGSize)boxSize withMode:(UIViewContentMode)mode
{
    CGFloat sx = boxSize.width/originalSize.width;
    CGFloat sy = boxSize.height/originalSize.height;
    CGFloat s = 1.0;
    
    switch (self.contentMode) {
        case UIViewContentModeScaleAspectFit:
            s = fminf(sx, sy);
            return CGSizeMake(s, s);
            break;
            
        case UIViewContentModeScaleAspectFill:
            s = fmaxf(sx, sy);
            return CGSizeMake(s, s);
            break;
            
        case UIViewContentModeScaleToFill:
            return CGSizeMake(sx, sy);
            
        default:
            return CGSizeMake(s, s);
    }
}


- (UIImage *)imageFromView:(UIView *)view
{
	// 必要なUIImageサイズ分のコンテキスト確保
	UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, 0);
	CGContextRef context = UIGraphicsGetCurrentContext();

	// 画像化する部分の位置を調整
	CGContextTranslateCTM(context, -view.frame.origin.x, -view.frame.origin.y);

	// 画像出力
	[view.layer renderInContext:context];

	// uiimage化
	UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();

	// コンテキスト破棄
	UIGraphicsEndImageContext();

	return renderedImage;
}

- (UIColor *)colorWithHex:(NSString *)colorCode alpha:(CGFloat)alpha
{
    if ([[colorCode substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"#"]) {
        colorCode = [colorCode substringWithRange:NSMakeRange(1, colorCode.length - 1)];
    }
	
    if ([colorCode length] == 3) {
        NSMutableString *_colorCode = [[NSMutableString alloc] init];
		
        for (NSInteger i = 0; i < colorCode.length; i++) {
            [_colorCode appendString:[colorCode substringWithRange:NSMakeRange(i, 1)]];
            [_colorCode appendString:[colorCode substringWithRange:NSMakeRange(i, 1)]];
        }
		
        colorCode = [_colorCode copy];
    }
	
    NSString *hexCodeStr;
    const char *hexCode;
    char *endptr;
    CGFloat red, green, blue;
	
    for (NSInteger i = 0; i < 3; i++) {
        hexCodeStr = [NSString stringWithFormat:@"+0x%@", [colorCode substringWithRange:NSMakeRange(i * 2, 2)]];
        hexCode    = [hexCodeStr cStringUsingEncoding:NSASCIIStringEncoding];
		
        switch (i) {
            case 0:
                red   = strtol(hexCode, &endptr, 16);
                break;
				
            case 1:
                green = strtol(hexCode, &endptr, 16);
                break;
				
            case 2:
                blue  = strtol(hexCode, &endptr, 16);
				
            default:
                break;
        }
    }
	
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}



@end
