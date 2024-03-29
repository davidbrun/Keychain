//
//  RootViewController.m
//  Keychain
//
//  Created by David Brun on 16/02/12.
//  Copyright 2012 ENSISA. All rights reserved.
//

#import "KeysViewController.h"
#import "KeychainAppDelegate.h"
#import "keyViewController.h"


@implementation KeysViewController

@synthesize keyViewController;


- (void)pushKeyViewController:(NSManagedObject *)key
{
	if(self.keyViewController == nil)
		self.keyViewController = [[keyViewController alloc] initWithNibName:@"KeyViewController" bundle:nil];
	self.keyViewController.key = key;
	[self.navigationController pushViewController:self.keyViewController animated:YES];
}

- (IBAction)createKey:(id)sender
{
	KeychainAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	NSManagedObjectContext *context = [appDelegate managedObjectContext];
	NSManagedObject *key = [NSEntityDescription insertNewObjectForEntityForName:@"Key" inManagedObjectContext:context];
    [self pushKeyViewController:key];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set up the edit button
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
	[self refreshTableView];
    [super viewWillAppear:animated];
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self allKeys] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    // Configure the cell.
	NSUInteger row = [indexPath row];
    NSManagedObject *key = [[self allKeys] objectAtIndex:row];
	cell.textLabel.text = [key valueForKey:@"name"];
    // Add the image of the category
    [cell.imageView setImage:[UIImage imageNamed:[key valueForKey:@"category"]]];
    cell.imageView.contentMode = UIViewContentModeCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove the key from the data base
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removeKey:[[self allKeys] objectAtIndex:[indexPath row]]];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{   // Disable the add button when we are in edition mode, re-enable it when we are no more in edition mode
    [self.navigationItem.rightBarButtonItem setEnabled:!editing];
    [super setEditing:editing animated:animate];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row];
	NSManagedObject *key = [[self allKeys] objectAtIndex:row];
	[self pushKeyViewController:key];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
}

// Get all the keys from the data base
- (NSArray *)allKeys
{
	KeychainAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Key" inManagedObjectContext:context];
	
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
    // Sort the objects
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
	
	NSError *error;
	NSArray *objects =[context executeFetchRequest:request error:&error];
	if (objects == nil )
		NSLog(@"Error when trying to reach the database");
	
	return objects;
}

// Remove a key from the data base
- (void)removeKey:(NSManagedObject *)key
{
    KeychainAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
	NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context deleteObject:key];
}

- (void) refreshTableView
{
    [self.tableView reloadData];
}

/*
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}
*/
/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

@end