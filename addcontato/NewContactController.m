//
//  ViewController.m
//  addcontato
//
//  Created by Stefanini Jaguariúna on 29/06/16.
//  Copyright © 2016 Stefanini Jaguariúna. All rights reserved.
//

#import "NewContactController.h"
#import <ContactsUI/ContactsUI.h>

@interface NewContactController () <CNContactViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic , strong) CNContactViewController *addNewContato;

@end

@implementation NewContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)addNewContato:(CNContact *)contact{
    
    CNContactViewController *addContactVC = [CNContactViewController viewControllerForNewContact:contact];
    addContactVC.delegate = self;
    addContactVC.allowsEditing = YES;
    addContactVC.allowsActions = YES;
    addContactVC.title = @"Novo Contato";
    
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Voltar" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    addContactVC.navigationItem.backBarButtonItem = backBarButton;
    
   // Display the view
    [self.navigationController pushViewController:addContactVC animated:YES];
}

-(void) backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createNewContact:(UIBarButtonItem *)sender {
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    CNContact *contact = [[CNContact alloc] init];

    if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (error) return;
            if (granted) {

                [self addNewContato:contact];
            }else{
                NSLog(@"Não autorizado");
            }
        }];
    }else if([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){
        
        [self addNewContato:contact];
    }else{
        NSLog(@"Não autorizado");
    }
}


@end
