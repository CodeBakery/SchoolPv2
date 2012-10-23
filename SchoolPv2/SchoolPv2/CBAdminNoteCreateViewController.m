#import "CBAdminNoteCreateViewController.h"
#import "CBScheduleService.h"
#import "CBDatabaseService.h"
#import "CBLecture.h"

@interface CBAdminNoteCreateViewController ()

@end

@implementation CBAdminNoteCreateViewController
{
    NSMutableDictionary *notesDic;
    NSMutableArray *allectures;
    NSString *lectureName;
    CBDatabaseService *dataBase;
    CBScheduleService *schedule;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dataBase = [CBDatabaseService database];
        allectures = [[NSMutableArray alloc] initWithArray:[dataBase getLectures]];
        notesDic = [[NSMutableDictionary alloc] init];
        schedule = [CBScheduleService schedule];
        
        UINavigationItem *item = [self navigationItem];
        [item setTitle:@"Add note"];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                    target:self
                                                                                    action:@selector(newNote:)];
        [item setRightBarButtonItem:doneButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _coursePickerView.delegate = self;
    _coursePickerView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{    
    return [allectures count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[allectures objectAtIndex:row] course];    
}

-(IBAction)newNote:(id)sender
{
    //NSLog(@"%@", lectureName);
    //NSLog(@"%@", _noteTextView.text);
    
    if (!([_noteTextView.text isEqualToString:@""]) && !([_coursePickerView isEqual:NULL]) && !([_superDayTextField.text isEqualToString:@""]) && !([_superWeekTextField.text isEqualToString:@""])) {
        
        [notesDic setValue:_noteTextView.text forKey:@"TEXT"];
        [notesDic setValue:_superWeekTextField.text forKey:@"WEEK"];
        [notesDic setValue:_superDayTextField.text forKey:@"DAY"];
        
        for (CBLecture *lec in allectures) {
            if (lec.course == lectureName) {
                [notesDic setValue:lec.courseID forKey:@"COURSEID"];
            }
        }
        NSLog(@"%@", [notesDic allValues]);
        [schedule createNote:notesDic];
        _noteTextView.text = @"Write a note here...";
        _superDayTextField.text = @"";
        _superWeekTextField.text = @"";
        
         
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saving Failed" message:@"You need to fill out all the fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
        
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    lectureName = [[allectures objectAtIndex:row] course];
    //NSLog(@"Selected %@", lectureName);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)superDayEnd:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)superWeekEnd:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)clickBG:(id)sender {
    [[self view] endEditing:YES];
}
@end
