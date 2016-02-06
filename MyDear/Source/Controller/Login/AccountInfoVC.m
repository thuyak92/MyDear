//
//  AccountInfoVC.m
//  MyDear
//
//  Created by phuongthuy on 1/20/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "AccountInfoVC.h"
#import "AppDelegate.h"

@interface AccountInfoVC ()

@end

@implementation AccountInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [LibRestKit share].delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btnBack.png"] style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(dismissModalViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(onSaveButtonClicked)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    [_imvAvatar.layer setMasksToBounds:YES];
    [_imvAvatar.layer setCornerRadius:20];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)onSaveButtonClicked
{
    [self postData];
}

- (IBAction)onSegmentChangeValue:(id)sender {
    if (sender == _segIdSearch) {
        idSearch = _segIdSearch.selectedSegmentIndex;
    } else if (sender == _segLocation) {
        location = _segLocation.selectedSegmentIndex;
    }
}

- (IBAction)onButtonClicked:(id)sender {
    if (sender == _btnCamera) {
        UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
        pickerLibrary.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerLibrary.delegate = self;
        [self presentViewController:pickerLibrary animated:NO completion:^{
            
        }];
    } else if (sender == _btnLibrary) {
        UIImagePickerController *pickerLibrary = [[UIImagePickerController alloc] init];
        pickerLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerLibrary.delegate = self;
        [self presentViewController:pickerLibrary animated:NO completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:NO completion:^{
    }];
    
    UIImage * img = info[UIImagePickerControllerOriginalImage];
    [_imvAvatar setImage:img];
    UIImage *postImg = [Lib squareImageWithImage:img scaledToSize:CGSizeMake(150, 150)];
    avatar = UIImageJPEGRepresentation(postImg, 0.0);
}

- (UserModel *)getUserData
{
    UserModel *user = [Lib currentUser];
    user.nickname = _txtfNickname.text;
    user.comment = _txtfComment.text;
    user.mySpot = _txtfMyspot.text;
//    user.searchId = idSearch;
//    user.searchLocation = location;

    return user;
}

- (void)postData
{
    [[LibRestKit share] postObject:[self getUserData] toPath:URL_UPDATE_USER method:RKRequestMethodPUT withData:avatar fileName:@"avatar_file" forClass:CLASS_USER];
}

#pragma mark - TextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [self.view setFrame:CGRectMake(0, -130 - textField.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtfNickname) {
        //press Next
        [_txtfComment becomeFirstResponder];
        // Scroll to selected row
        return NO;
    } else if (textField == _txtfComment) {
        //press Next
        [_txtfMyspot becomeFirstResponder];
        // Scroll to selected row
        return NO;
    }
    else
    {
        //press Done
        [_txtfMyspot resignFirstResponder];
        [textField endEditing:YES];
        return YES;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark - RestKit Delegate

- (void)onPostObjectSuccess: (LibRestKit *)controller data: (id)object
{
    [Lib setCurrentUser:(UserModel *)object];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app switchToTabWithIndex:TAB_HOME];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
