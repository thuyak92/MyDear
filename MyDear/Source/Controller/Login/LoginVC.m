//
//  LoginVC.m
//  MyDear
//
//  Created by phuongthuy on 1/18/16.
//  Copyright © 2016 PhuongThuy. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [LibRestKit share].delegate = self;
    // Do any additional setup after loading the view.
    
    
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

- (UserModel *)getInfo
{
    UserModel *user = [[UserModel alloc] init];
    user.email = _txtfUsername.text;
    user.password = _txtfPassword.text;
    return user;
}

- (BOOL)validate: (UserModel *)user
{
    if (!user.email || user.email.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"エラー" message:@"メールを入力してください。" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return FALSE;
    }
    if (![Lib checkEmailValid:user.email]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"エラー" message:@"メールは正しくありません。" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return FALSE;
    }
    if (!user.password || user.password.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"エラー" message:@"パスワードを入力してください。" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return FALSE;
    }
    return TRUE;
}

- (IBAction)onLoginButtonClicked:(id)sender {
    if (sender == _btnLogin) {
        url = URL_LOGIN;
    } else {
        url = URL_REGISTER;
    }
    UserModel *user = [self getInfo];
    if (![self validate:user]) {
        return;
    }
    [[LibRestKit share] postObject:user toPath:url forClass:CLASS_USER];
}

- (IBAction)onCancelButtonClicked:(id)sender {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app switchToTabWithIndex:TAB_HOME];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onLoginTwitterButtonClicked:(id)sender {
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"signed in as %@", [session userName]);
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
}

- (IBAction)onLoginFacebookButtonClicked:(id)sender {
    _btnLoginFb.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
}

#pragma mark - FB login delegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    if (error) {
        NSLog(@"Process error");
    } else if (result.isCancelled) {
        NSLog(@"Cancelled");
    } else {
        NSLog(@"Logged in");
    }
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    
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
    if (textField == _txtfUsername) {
        //press Next
        [_txtfPassword becomeFirstResponder];
        // Scroll to selected row
        return NO;
    }
    else
    {
        //press Done
        [_txtfPassword resignFirstResponder];
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
    UserModel *user = (UserModel *)object;
    if (user == nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Have some errors!" preferredStyle: UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        if (user.error == nil) {//success
            [Lib setCurrentUser:user];
#warning T redirect to SEGUE_LOGIN_TO_USER_INFO if register success
            AppDelegate *app = [UIApplication sharedApplication].delegate;
            [app switchToTabWithIndex:TAB_HOME];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [Lib handleError:user.error forController:self];
        }
    }
}


@end
