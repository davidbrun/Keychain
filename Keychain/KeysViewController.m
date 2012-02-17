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
    [key setValue:@"Nouvelle clé" forKey:@"name"];
    [self pushKeyViewController:key];
    //[self refreshTableView];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
/*
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createKey)];
    //@selector(insertNewObject)
    //[super ta
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];*/
}

- (void)viewWillAppear:(BOOL)animated
{
	[self refreshTableView];
    [super viewWillAppear:animated];
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
	NSUInteger row = [indexPath row];
    NSManagedObject *computer = [[self allKeys] objectAtIndex:row];
	cell.textLabel.text = [computer valueForKey:@"name"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removeKey:[[self allKeys] objectAtIndex:[indexPath row]]];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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

- (NSArray *)allKeys
{
	KeychainAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
	
	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Key" inManagedObjectContext:context];
	
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
	
	NSError *error;
	NSArray *objects =[context executeFetchRequest:request error:&error];
	if (objects == nil ){
		NSLog(@"There was an error");
	}
	return objects;
}

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
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

@end
