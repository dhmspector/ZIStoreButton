/*
//  ZIStoreButtonDemoViewController.m
//  ZIStoreButtonDemo
//
//  Created by Brandon Emrich on 7/20/10.
//  Specialized customizations by David HM Spector <spector@zeitgeist.com> on 12/16/2010
*/

/*
//	Copyright 2010 Brandon Emrich
//  Additions Copyright 2010 David HM Spector
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

#import "ZIStoreButtonDemoViewController.h"
#import "ZIStoreButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation ZIStoreButtonDemoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *myCustomizations = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:showingComingSoon], @"startingMode",
                                    @"$3.99", @"priceString",
                                    @"BUY ME!", @"buyNowString",
                                    @"Installed!", @"alreadyInstalledString",
                                    @"Coming 2011", @"comingSoonString",
                                    
                                    [NSArray arrayWithObjects:(id)[UIColor colorWithRed:0.306 green:0.380 blue:0.547 alpha:1.000].CGColor,
                                     [UIColor colorWithRed:0.258 green:0.307 blue:0.402 alpha:1.000].CGColor,
                                     [UIColor colorWithRed:0.159 green:0.270 blue:0.550 alpha:1.000].CGColor,
                                     [UIColor colorWithRed:0.129 green:0.220 blue:0.452 alpha:1.000].CGColor, nil], @"priceColors",
                                    
                                    
                                    [NSArray arrayWithObjects:(id)
                                     [UIColor colorWithRed:0.482 green:0.674 blue:0.406 alpha:1.000].CGColor,
                                     [UIColor colorWithRed:0.525 green:0.742 blue:0.454 alpha:1.000].CGColor,
                                     [UIColor colorWithRed:0.346 green:0.719 blue:0.183 alpha:1.000].CGColor,
                                     [UIColor colorWithRed:0.299 green:0.606 blue:0.163 alpha:1.000].CGColor, nil], @"buyColors",
                                    
                                    [NSArray arrayWithObjects:(id)
                                     [UIColor colorWithRed:0.660 green:0.660 blue:0.660 alpha:1.000].CGColor,                                       
                                     [UIColor colorWithRed:0.660 green:0.660 blue:0.660 alpha:1.000].CGColor,
                                     [UIColor colorWithRed:0.660 green:0.660 blue:0.660 alpha:1.000].CGColor,                                        
                                     [UIColor colorWithRed:0.660 green:0.660 blue:0.660 alpha:1.000].CGColor, nil], @"alreadyInstalledColors",
                                    
                                    [NSArray arrayWithObjects:(id)
                                     [UIColor colorWithRed:0.631 green:0.208 blue:0.086 alpha:1.000].CGColor,                                       
                                     [UIColor colorWithRed:0.600 green:0.180 blue:0.066 alpha:1.000].CGColor,
                                     [UIColor colorWithRed:0.660 green:0.660 blue:0.660 alpha:1.000].CGColor,                                        
                                     [UIColor colorWithRed:0.729 green:0.325 blue:0.204 alpha:1.000].CGColor, nil], @"comingSoonColors"
                                    
                                    ,nil];
    
    
	ZIStoreButton *button = [[ZIStoreButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 85.0, 22.0) customizations:myCustomizations];
    
	button.center = self.view.center;
	
	CAGradientLayer *bgLayer = [self backgroundLayer];
	bgLayer.frame = self.view.bounds;
	
	[self.view.layer addSublayer:bgLayer];
	
	[self.view addSubview:button];
	
	UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 10.0, 320.0, 35.0)];
	titleLab.backgroundColor = [UIColor clearColor];
	titleLab.text = @"ZIStoreButton";
	titleLab.font = [UIFont systemFontOfSize:24.0];
	titleLab.textAlignment = UITextAlignmentCenter;
	titleLab.shadowColor = [UIColor colorWithWhite:0.98 alpha:1.0];
	titleLab.shadowOffset = CGSizeMake(0.0, 0.75);
	titleLab.textColor = [UIColor colorWithWhite:0.50 alpha:1.0];
	
	[self.view addSubview:titleLab];
	
	UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 55.0, 300.0, 120.0)];
	detailLab.backgroundColor = [UIColor clearColor];
	detailLab.numberOfLines = 7;
	detailLab.text = @"  This is a UIButton subclass that use's Core Animation Layers to present itself.  A CAAnimation is rendered using the keypath for the 'colors' property of the CAGradeintLayer.\n\n  Not a single image resource is ever used to render any part of the button.";
	detailLab.font = [UIFont systemFontOfSize:13.0];
	detailLab.shadowColor = [UIColor colorWithWhite:0.98 alpha:1.0];
	detailLab.shadowOffset = CGSizeMake(0.0, 1.0);
	detailLab.textColor = [UIColor colorWithWhite:0.50 alpha:1.0];
	
	[self.view addSubview:detailLab];
}


- (CAGradientLayer*) backgroundLayer {
	
	UIColor *colorOne		= [UIColor colorWithWhite:0.9 alpha:1.0];
	UIColor *colorTwo		= [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.85 alpha:1.0];
	UIColor *colorThree	    = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0];
	UIColor *colorFour		= [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.4 alpha:1.0];
		
	NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor, nil];
	
	NSNumber *stopOne		= [NSNumber numberWithFloat:0.0];
	NSNumber *stopTwo		= [NSNumber numberWithFloat:0.02];
	NSNumber *stopThree	    = [NSNumber numberWithFloat:0.99];
	NSNumber *stopFour		= [NSNumber numberWithFloat:1.0];
	
	NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, nil];
	
	CAGradientLayer *headerLayer = [CAGradientLayer layer];
	//headerLayer.frame = CGRectMake(0.0, 0.0, 320.0, 77.0);
	headerLayer.colors = colors;
	headerLayer.locations = locations;
	
	return headerLayer;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
