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
@synthesize categoryPicker;
@synthesize pickerData;
@synthesize key;


-(void)viewWillAppear:(BOOL)animated
{
    // Complete the fields with data from the selected key
	self.nameField.text = [self.key valueForKey:@"name"];
	self.urlField.text = [self.key valueForKey:@"url"];
    self.loginField.text = [self.key valueForKey:@"login"];
    self.passwordField.text = [self.key valueForKey:@"password"];
    // Select the correct row of the picker
    NSUInteger index = [pickerData indexOfObject:[self.key valueForKey:@"category"]];
    if (index != NSNotFound)
        [self.categoryPicker selectRow:index inComponent:0 animated:NO];
    else
        [self.categoryPicker selectRow:0 inComponent:0 animated:NO];
    
    // Put the name of the key as a title
    [self.navigationItem setTitle:[self.key valueForKey:@"name"]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    // Store the data in the selected key
	[self.key setValue:self.nameField.text forKey:@"name"];
    [self.key setValue:self.urlField.text forKey:@"url"];
    [self.key setValue:self.loginField.text forKey:@"login"];
    [self.key setValue:self.passwordField.text forKey:@"password"];
    // Store the category (actually the name of the picture associated)
    NSInteger row = [categoryPicker selectedRowInComponent:0];
    NSString *selected = [pickerData objectAtIndex:row];
    [self.key setValue:selected forKey:@"category"];
    [selected release];
    
    // Hide the keyboard
    [self backgroundTap:self];
}

// Hide the keyboard
- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}
- (IBAction)backgroundTap:(id)sender
{
    [nameField resignFirstResponder];
    [urlField resignFirstResponder];
    [loginField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (IBAction)buttonGenerateTouch:(id)sender
{
    [passwordField setText:[self generateKeyOfLength:8]];
}

// Generate a random string of the specified length
- (NSString *)generateKeyOfLength:(NSUInteger)length
{
    NSString * alphabet = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *s = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0U; i < length; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    [alphabet release];
    return [NSString stringWithString:s];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 46)];
    imgView.image = [UIImage imageNamed:[pickerData objectAtIndex:row]];
    imgView.contentMode = UIViewContentModeCenter;
    return imgView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerData objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    // Create 4 categories
    NSArray *array = [[NSArray alloc] initWithObjects:@"email.png",@"bank.png",@"shopping.png",@"game.png",nil];
    self.pickerData = array;
    [array release];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.nameField = nil;
	self.urlField = nil;
    self.loginField = nil;
    self.passwordField = nil;
    self.categoryPicker = nil;
    self.pickerData = nil;
}


- (void)dealloc
{
	[nameField release];
	[urlField release];
    [loginField release];
    [passwordField release];
    [categoryPicker release];
    [pickerData release];
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