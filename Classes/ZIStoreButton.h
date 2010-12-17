//
//  ZIStoreButton.h
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

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define ZI_BUY_NOW_TITLE @"Buy Now"
#define ZI_COMING_SOON_TITLE @"Comming Soon"
#define ZI_ALREADY_INSTALLED_TITLE @"Installed"

#define ZI_MAX_WIDTH 120.0f
#define ZI_PADDING 10.0f

typedef void (^ActionBlock)();


typedef enum {
    showingPrice = 1, 
    showingInstalled,
    showingPurchase,
    showingComingSoon
} StoreButtonModes;

@protocol ZIStoreButtonDelegate
@required
/**
	User clicks on the purchase button
 */
- (void)ZIStoreButtonDidRecieveBuyEvent;

@optional

- (void)ZIStoreButtonDidRecievePriceEvent;


/**
	User clicked outside the button, causing it to revert to the showingPrice state
    just like on the App Store
 */
- (void)ZIStoreButtonDidRevert;
@end

@interface ZIStoreButton : UIButton {
	CAGradientLayer *innerLayer3;
	BOOL isBlued;
    
    NSString *priceString;
    NSString *buyNowString;
    NSString *installedString;
    NSString *comingSoonString;
    
	ActionBlock _actionBlock;
    StoreButtonModes startingMode;
    StoreButtonModes currentMode;

    // this is an array of user-supplied colors for our gradients;
    // if they're not supplied, we'll use some defaults
    NSArray *priceColors; 
    NSArray *buyColors;
    NSArray *alreadyInstalledColors;
    NSArray *comingSoonColors;
}
@property (nonatomic, retain) CAGradientLayer *innerLayer3;
@property (nonatomic, getter=isBlued) BOOL isBlued;
@property (nonatomic, copy) NSString *priceString;
@property (nonatomic, copy) NSString *buyNowString;
@property (nonatomic, copy) NSString *installedString;
@property (nonatomic, copy) NSString *comingSoonString;
@property (nonatomic) StoreButtonModes startingMode;
@property (nonatomic) StoreButtonModes currentMode;
@property (nonatomic, copy) NSArray *priceColors;
@property (nonatomic, copy) NSArray *buyColors;
@property (nonatomic, copy) NSArray *alreadyInstalledColors;
@property (nonatomic, copy) NSArray *comingSoonColors;



- (id)initWithFrame:(CGRect)frame customizations:(NSDictionary *)customizations;

-(void)setBuyBlock:(ActionBlock)action;


@end
