#import "CBAdminCreateMessageViewController.h"
#import "CBMessage.h"
#import "CBDatabaseService.h"
#import "CBDayViewController.h"
#import "CBUser.h"
#import "CBScheduleService.h"

@interface CBAdminCreateMessageViewController ()

@end

@implementation CBAdminCreateMessageViewController
{
    NSMutableArray *allReceivers;
    NSMutableDictionary *messageDictionary;
    CBDatabaseService *dataBase;
    CBScheduleService *schedule;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataBase = [CBDatabaseService database];
        messageDictionary = [[NSMutableDictionary alloc]init];
        schedule = [CBScheduleService schedule];
        UINavigationItem *item = [self navigationItem];
        [item setTitle:@"New Message"];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(newMessage:)];
        [item setRightBarButtonItem:doneButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)mailTextFieldDo:(id)sender {
    NSLog(@"HEJ");
    [sender resignFirstResponder];
}

- (IBAction)clickBG:(id)sender {
    [[self view] endEditing:YES];
}

-(IBAction)newMessage:(id)sender
{
    NSLog(@"%@",_mailTextField.text);
    NSLog(@"%@", _messageTextField.text);
    if (!([_mailTextField.text isEqualToString:@""]) && !([_messageTextField.text isEqualToString:@""])) {
        NSLog(@"OK");
        [messageDictionary setValue:_messageTextField.text forKey:@"TEXT"];
        [messageDictionary setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"SchoolP_user"] forKey:@"SENDER"];
        
        allReceivers = [[NSMutableArray alloc] init];
        allReceivers = [[[[_mailTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""] capitalizedString] componentsSeparatedByString:@","] mutableCopy];
            [messageDictionary setValue:allReceivers forKey:@"RECEIVER"];
        
        
        NSLog(@"%@", [messageDictionary allValues]);
        [schedule createMessage:messageDictionary];
        _messageTextField.text = @"";
        _mailTextField.text = @"";
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saving Failed" message:@"You need to fill out all the fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}








@end