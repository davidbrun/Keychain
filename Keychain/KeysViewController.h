//
//  RootViewController.h
//  Keychain
//
//  Created by David Brun on 16/02/12.
//  Copyright 2012 ENSISA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class keyViewController;

@interface KeysViewController : UITableViewController {
	keyViewController *keyViewController;
}

@property (nonatomic,retain) keyViewController * keyViewController;

- (IBAction)createKey:(id)sender;
- (void)removeKey:(NSManagedObject *)key;
- (NSArray *)allKeys;

@end
