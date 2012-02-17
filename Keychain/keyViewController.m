//
//  keyViewController.m
//  Keychain
//
//  Created by David Brun on 17/02/12.
//  Copyright 2012 ENSISA. All rights reserved.
//

#import "keyViewController.h"

@implementation keyViewController

@synthesize nameField, urlField, loginField, passwordField;
@synthesize key;



-(void)viewWillAppear:(BOOL)animated{
	self.nameField.text = [self.key valueForKey:@"name"];
	self.urlField.text = [self.key valueForKey:@"url"];
    self.loginField.text = [self.key valueForKey:@"login"];
    self.passwordField.text = [self.key valueForKey:@"password"];
}


-(void)viewWillDisappear:(BOOL)animated{
	[self.key setValue:self.nameField.text forKey:@"name"];
    [self.key setValue:self.urlField.text forKey:@"url"];
    [self.key setValue:self.loginField.text forKey:@"login"];
    [self.key setValue:self.passwordField.text forKey:@"password"];
}


/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
/*
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
*/
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.nameField = nil;
	self.urlField = nil;
    self.loginField = nil;
    self.passwordField = nil;
}


- (void)dealloc {
	[nameField release];
	[urlField release];
    [loginField release];
    [passwordField release];
	[key release];
    [super dealloc];
}
/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
@end
