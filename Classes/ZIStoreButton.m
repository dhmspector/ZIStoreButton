//
//  ZIStoreButton.m
//  ZIStoreButtonDemo
//
//  Created by Brandon Emrich on 7/20/10.
//  Copyright 2010 Zueos, Inc. All rights reserved.
//

/*
 //	Copyright 2010 Brandon Emrich
 //
 //	Licensed under the Apache License, Version 2.0 (the "License");
 //	you may not use this file except in compliance with the License.
 //	You may obtain a copy of the License at
 //
 //	http://www.apache.org/licenses/LICENSE-2.0
 //
 //	Unless required by applicable law or agreed to in writing, software
 //	distributed under the License is distributed on an "AS IS" BASIS,
 //	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 //	See the License for the specific language governing permissions and
 //	limitations under the License.
 */

#import "ZIStoreButton.h"



@implementation ZIStoreButton

@synthesize innerLayer3;
@synthesize isBlued;
@synthesize priceString;
@synthesize buyNowString;
@synthesize installedString;
@synthesize comingSoonString;
@synthesize startingMode;
@synthesize currentMode;
@synthesize priceColors;
@synthesize buyColors;
@synthesize alreadyInstalledColors;
@synthesize comingSoonColors;





-(void)setBuyBlock:(ActionBlock) action {
	_actionBlock = Block_copy(action);
}

-(void) callActionBlock:(id)sender{
	if (_actionBlock) _actionBlock();
}




- (id)initWithFrame:(CGRect)frame customizations:(NSDictionary *)customizations {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		_actionBlock = nil;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		self.autoresizesSubviews = YES;
		self.layer.needsDisplayOnBoundsChange = YES;
		
		isBlued = NO;
        
        // The customization keys must be any of:
        // StoreButtonModes which is an enum
        if ([customizations valueForKey:@"startingMode"])
            self.startingMode = (StoreButtonModes)[[customizations objectForKey:@"startingMode"] intValue];
        else
            self.startingMode = showingPrice;
        
        // Store Button string properties:
        //  priceString, buyNowString, installedString, comingSoonString    
        if (!(self.priceString = [customizations objectForKey:@"priceString"])) 
            self.priceString = ZI_PRICE_STRING; // user really DOES need to set at least this one!
        
        if (!(self.buyNowString = [customizations objectForKey:@"buyNowString"])) 
            self.buyNowString = ZI_BUY_NOW_TITLE; 
        
        if (!(self.installedString = [customizations objectForKey:@"alreadyInstalledString"])) 
            self.installedString = ZI_ALREADY_INSTALLED_TITLE; 
        
        if (!(self.comingSoonString = [customizations objectForKey:@"comingSoonString"])) 
            self.comingSoonString = ZI_COMING_SOON_TITLE;
        
        [self setTitle:self.priceString forState:UIControlStateNormal];
		[self setTitleShadowColor:[UIColor colorWithWhite:0.200 alpha:1.000] forState:UIControlStateNormal];

        [self setTitle:self.buyNowString forState:UIControlStateSelected];
		[self setTitleShadowColor:[UIColor colorWithWhite:0.200 alpha:1.000] forState:UIControlStateSelected];

		[self.titleLabel setShadowOffset:CGSizeMake(0.0, -0.6)];
		[self.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
		self.titleLabel.textColor = [UIColor colorWithWhite:0.902 alpha:1.000];
        
        
        // Arrays of CGColor values map to the following keys:
        //    priceColors, buyColors, alreadyInstalledColors, comingSoonColors        
        if (customizations) {
            if (!(self.priceColors = [customizations objectForKey:@"priceColors"])) 
            {               // blue-gray, just like in the App Store
                self.priceColors = [NSArray arrayWithObjects:(id)                           
                               [UIColor colorWithRed:0.306 green:0.380 blue:0.547 alpha:1.000].CGColor,
                               [UIColor colorWithRed:0.258 green:0.307 blue:0.402 alpha:1.000].CGColor,
                               [UIColor colorWithRed:0.159 green:0.270 blue:0.550 alpha:1.000].CGColor,
                               [UIColor colorWithRed:0.129 green:0.220 blue:0.452 alpha:1.000].CGColor,
                               nil];
//                [priceColors retain];
            }
            if (!(self.buyColors = [customizations objectForKey:@"buyColors"])) {
                // Medium Green
                self.buyColors = [NSArray arrayWithObjects:(id)
                             [UIColor colorWithRed:0.482 green:0.674 blue:0.406 alpha:1.000].CGColor,
                             [UIColor colorWithRed:0.525 green:0.742 blue:0.454 alpha:1.000].CGColor,
                             [UIColor colorWithRed:0.346 green:0.719 blue:0.183 alpha:1.000].CGColor,
                             [UIColor colorWithRed:0.299 green:0.606 blue:0.163 alpha:1.000].CGColor,
                             nil];
//                [buyColors retain];
            }
            if (!(self.alreadyInstalledColors = [customizations objectForKey:@"alreadyInstalledColors"])) {
                // Slate Gray
                self.alreadyInstalledColors = [NSArray arrayWithObjects:(id)
                                          [UIColor colorWithRed:0.660 green:0.660 blue:0.660 alpha:1.000].CGColor,                                       
                                          [UIColor colorWithRed:0.660 green:0.660 blue:0.660 alpha:1.000].CGColor,
                                          [UIColor colorWithRed:0.660 green:0.660 blue:0.660 alpha:1.000].CGColor,                                        
                                          [UIColor colorWithRed:0.660 green:0.660 blue:0.660 alpha:1.000].CGColor,                                        
                                          nil];
//                [alreadyInstalledColors retain];
            }
            if (!(self.comingSoonColors = [customizations objectForKey:@"comingSoonColors"])) {
                // Rust orange
                self.comingSoonColors = [NSArray arrayWithObjects:(id)
                                    [UIColor colorWithRed:0.631 green:0.208 blue:0.086 alpha:1.000].CGColor,                                       
                                    [UIColor colorWithRed:0.600 green:0.180 blue:0.066 alpha:1.000].CGColor,
                                    [UIColor colorWithRed:0.580 green:0.160 blue:0.440 alpha:1.000].CGColor,                                        
                                    [UIColor colorWithRed:0.560 green:0.140 blue:0.220 alpha:1.000].CGColor,                                        
                                    nil];
//                [comingSoonColors retain];            
            }
                
        } // of customizations
        
		
		[self addTarget:self action:@selector(touchedUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
		[self addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
		
		CAGradientLayer *bevelLayer2 = [CAGradientLayer layer];
		bevelLayer2.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.4 alpha:1.0] CGColor], [[UIColor whiteColor] CGColor], nil];
		bevelLayer2.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(frame), CGRectGetHeight(frame));
		bevelLayer2.cornerRadius = 2.5; //5.0;
		bevelLayer2.needsDisplayOnBoundsChange = YES;
		
		CAGradientLayer *innerLayer2 = [CAGradientLayer layer];
		innerLayer2.colors = [NSArray arrayWithObjects:(id)[[UIColor darkGrayColor] CGColor], [[UIColor lightGrayColor] CGColor], nil];
		innerLayer2.frame = CGRectMake(0.5, 0.5, CGRectGetWidth(frame) - 1.0, CGRectGetHeight(frame) - 1.0);
		innerLayer2.cornerRadius = 2.6; //4.6;
		innerLayer2.needsDisplayOnBoundsChange = YES;
		      
		innerLayer3 = [CAGradientLayer layer];
        
        // this is our starting mode which can be set by the user by setting the properties
        switch (startingMode) {
            case showingPrice:
                innerLayer3.colors = self.priceColors;                  //blueColors;
                [self setTitle:priceString forState:UIControlStateNormal];
                break;
            case showingInstalled:
                innerLayer3.colors = self.alreadyInstalledColors;       //grayColors;
                 [self setTitle:installedString forState:UIControlStateNormal];
                [self setEnabled:NO];
                break;
            case showingPurchase:
                innerLayer3.colors = self.buyColors;                    //greenColors;
                [self setTitle:buyNowString forState:UIControlStateSelected];
                break;
            case showingComingSoon:
                innerLayer3.colors = self.comingSoonColors;
                [self setTitle:comingSoonString forState:UIControlStateNormal];
                [self setEnabled:NO];
                break;
            default:
                break;
        }
        
		//innerLayer3.colors = blueColors;
		innerLayer3.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.500], [NSNumber numberWithFloat:0.5001], [NSNumber numberWithFloat:1.0], nil];		
		innerLayer3.frame = CGRectMake(0.75, 0.75, CGRectGetWidth(frame) - 1.5, CGRectGetHeight(frame) - 1.5);
		innerLayer3.cornerRadius = 2.5; //4.5;
		innerLayer3.needsDisplayOnBoundsChange = YES;
		
		[self.layer addSublayer:bevelLayer2];
		[self.layer addSublayer:innerLayer2];
		[self.layer addSublayer:innerLayer3];
        
		
		[self bringSubviewToFront:self.titleLabel];
    }
    return self;
}


- (void) setSelected:(BOOL)selected {
	
	[super setSelected:selected];
	
	[CATransaction begin];
	[CATransaction setAnimationDuration:0.25];
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    
    
//	animation.fromValue = (!self.selected) ? self.buyColors : self.priceColors;
//	animation.toValue = (!self.selected) ? self.priceColors : self.buyColors;

	animation.fromValue = (!self.selected) ? self.buyColors : self.priceColors;
	animation.toValue = (!self.selected) ? self.priceColors : self.buyColors;
    
    
	animation.duration = 0.25;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	animation.delegate = self;
	
	[innerLayer3 layoutIfNeeded];
	[innerLayer3 addAnimation:animation forKey:@"changeToBlue"];
	
	NSString *title = (self.selected ? [self titleForState:UIControlStateSelected] : [self titleForState:UIControlStateNormal]);
	CGSize constr = (CGSize){.height = self.frame.size.height, .width = ZI_MAX_WIDTH};
	CGSize newSize = [title sizeWithFont:self.titleLabel.font constrainedToSize:constr lineBreakMode:UILineBreakModeMiddleTruncation];
	CGFloat newWidth = newSize.width + (ZI_PADDING * 2);
	CGFloat diff = self.frame.size.width - newWidth;
	

	for (CALayer *la in self.layer.sublayers) {
		CGRect cr = la.bounds;
		cr.size.width = cr.size.width;
		cr.size.width = newWidth;
		la.bounds = cr;
		[la layoutIfNeeded];
	}
	
	CGRect cr = self.frame;
	cr.size.width = cr.size.width;
	cr.size.width = newWidth;
	self.frame = cr;
	self.titleEdgeInsets = UIEdgeInsetsMake(2.0, self.titleEdgeInsets.left + diff, 0.0, 0.0);	
	[CATransaction commit];
    
    NSLog(@"%@", [NSString stringWithFormat:@"UIControlStateSelected title: \"%@\"  UIControlStateNormal title: \"%@\" ", 
                  [self titleForState:UIControlStateSelected], [self titleForState:UIControlStateNormal]]);
//    NSLog(@"%@", [NSString stringWithFormat:@"Button label color for UIControlStateNormal is %@;  UIControlStateSelected is %@", 
//                [[self titleColorForState:UIControlStateNormal] description],[[self titleColorForState:UIControlStateSelected] description]]);

}

- (IBAction) touchedUpOutside:(id)sender {
	if (self.selected) {
		[self setSelected:NO];
	}
}


- (IBAction) pressButton:(id)sender {
	if (isBlued) {
		[self callActionBlock:sender];
		[sender setSelected:NO];
		isBlued = NO;
	} else {
		
		[sender setSelected:YES];
		isBlued = YES;
	}
}


- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
#ifdef DEBUG
	NSLog(@"Animation Did Stop");
#endif
}


- (void)dealloc {
	Block_release(_actionBlock);
    
    [innerLayer3 release];
    innerLayer3 = nil;
    [priceString release];
    priceString = nil;
    [buyNowString release];
    buyNowString = nil;

    [installedString release];
    installedString = nil;
    [comingSoonString release];
    comingSoonString = nil;
    [priceColors release];
    priceColors = nil;
    [buyColors release];
    buyColors = nil;
    [alreadyInstalledColors release];
    alreadyInstalledColors = nil;
    [comingSoonColors release];
    comingSoonColors = nil;
    
    
    [super dealloc];
}


@end
