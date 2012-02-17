//
//  keyViewController.h
//  Keychain
//
//  Created by David Brun on 17/02/12.
//  Copyright 2012 ENSISA. All rights reserved.
//



@interface keyViewController : UIViewController {

    UITextField *nameField;
    UITextField *urlField;
    UITextField *loginField;
    UITextField *passwordField;
    NSManagedObject *key;

}

@property (nonatomic,retain) IBOutlet UITextField *nameField;
@property (nonatomic,retain) IBOutlet UITextField *urlField;
@property (nonatomic,retain) IBOutlet UITextField *loginField;
@property (nonatomic,retain) IBOutlet UITextField *passwordField;
@property (nonatomic,retain) NSManagedObject *key;//pointera vers l'objet persistant qu'on modifie

@end