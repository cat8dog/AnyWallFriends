#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)userLogin:(id)sender
{
    [self processFieldEntries];
}

- (void)processFieldEntries
{
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    NSString *noUserNameText = @"username";
    NSString *noPasswordText = @"password";
    NSString *errorText = @"No ";
    NSString *errorTextJoin = @" or ";
    NSString *errorTextEnding = @" entered";
    BOOL textError = NO;
    
    if (password.length == 0)
    {
        [self.passwordField becomeFirstResponder];
    }
    if (username.length == 0)
    {
        [self.usernameField becomeFirstResponder];
    }
    
    if ([username length] == 0)
    {
        textError = YES;
        errorText = [errorText stringByAppendingString:noUserNameText];
    }
    
    if ([password length] == 0)
    {
        textError = YES;
        if ([username length] == 0)
        {
            errorText = [errorText stringByAppendingString:errorTextJoin];
        }
        errorText = [errorText stringByAppendingString:noPasswordText];
    }
    
    if (textError)
    {
        errorText = [errorText stringByAppendingString:errorTextEnding];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorText message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alertView show];
        
        return;
    }
    
    [PFUser logInWithUsernameInBackground:username password:password block:^ (PFUser *user, NSError *error)
    {
        if (user)
        {
            [self performSegueWithIdentifier:@"loginButton" sender:self];
        }
        else
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Try Again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                 [alert show];
             }
        }];
    }
        
        

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
