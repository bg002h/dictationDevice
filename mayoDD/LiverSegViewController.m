//
//  LiverSegViewController.m
//  mayoDD
//
//  Created by Brian Goss on 11/15/13.
//
//

#import "LiverSegViewController.h"
#import "LiverViewController.h"


@interface LiverSegViewController ()

@end
@implementation LiverSegViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"init with nib name coalled...hmm...");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lblLiverSegment.text=self.segueName;
    self.buttons = @[self.btnCyst, self.btnSimpleCyst, self.btnComplexCyst, self.btnHemangioma, self.btnProbableHemangioma, self.btnAtypicalHemangioma, self.btnMass, self.btnHypoechoicMass, self.btnHyperechoicMass, self.btnHypoRimMass, self.btnHeterogeneousMass, self.btnMetastasisMass, self.btnProbableMetastasisMass, self.btnPossibleMetastasisMass, self.btnKnownMetastasisMass];
    self.textFields = @[self.tfCystSize, self.tfHemangiomaSize, self.tfMassSize];
    
    [self setupButtonStatesDisplay];
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.tfCystSize.inputAccessoryView = numberToolbar;
    self.tfHemangiomaSize.inputAccessoryView=numberToolbar;
    self.tfMassSize.inputAccessoryView=numberToolbar;
    self.tfCystSize.delegate=self;
    self.tfHemangiomaSize.delegate=self;
    self.tfMassSize.delegate=self;
    
	// Do any additional setup after loading the view.
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //reset buttons here
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) setupButtonStatesDisplay{
    int idx = 0;
    for (UIButton *btn in self.buttons){
        if ([self.ButtonStates characterAtIndex:idx] == '1'){
            [btn setSelected:YES];
        } else {
            [btn setSelected:NO];
        }
        idx++;
    }
    idx=0;
    NSArray *tmp = [self.ButtonStates componentsSeparatedByString:@"|"];
    UITextField *tmpTF;
    for (NSString *s in tmp){
 //       float size = [s floatValue];
        if (idx >0){
            tmpTF=[[self textFields] objectAtIndex:idx-1];
            tmpTF.text=s;
        }
        idx++;
    }
    
    
}
- (void) toggleButtonStatesString:(int) index{
    index = index-1;
    if ([self.ButtonStates characterAtIndex:index]=='0'){
        self.ButtonStates = [self.ButtonStates stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:@"1"].mutableCopy;
    } else {
        self.ButtonStates = [self.ButtonStates stringByReplacingCharactersInRange:NSMakeRange(index, 1) withString:@"0"].mutableCopy;
    }
}
- (IBAction)btnDone:(UIButton *)sender {
    //update liver seg stats and dismiss
    //update here
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnPressed:(UIButton *)sender {
    [sender setSelected:![sender isSelected]];
    [self toggleButtonStatesString:[sender tag]];
    if (([sender tag]==2 || [sender tag]==3) && ![(UIButton*)[self.view viewWithTag:1] isSelected]){
        [(UIButton*)[self.view viewWithTag:1] setSelected:![(UIButton*)[self.view viewWithTag:1] isSelected]];
        [self toggleButtonStatesString:1];
    }
    if (([sender tag]==5 || [sender tag]==6) && ![(UIButton*)[self.view viewWithTag:4] isSelected]){
        [(UIButton*)[self.view viewWithTag:4] setSelected:![(UIButton*)[self.view viewWithTag:4] isSelected]];
        [self toggleButtonStatesString:4];
    }
    
    if (([sender tag]==1 && ![(UIButton*)[self.view viewWithTag:1] isSelected]) && ([(UIButton*)[self.view viewWithTag:2] isSelected] || [(UIButton*)[self.view viewWithTag:3] isSelected])){
        
        if ([(UIButton*)[self.view viewWithTag:2] isSelected]){
        [(UIButton*)[self.view viewWithTag:2] setSelected:![(UIButton*)[self.view viewWithTag:2] isSelected]];
        [self toggleButtonStatesString:2];
        }

        if ([(UIButton*)[self.view viewWithTag:3] isSelected]){
            [(UIButton*)[self.view viewWithTag:3] setSelected:![(UIButton*)[self.view viewWithTag:3] isSelected]];
            [self toggleButtonStatesString:3];
        }

    }

    if (([sender tag]==4 && ![(UIButton*)[self.view viewWithTag:4] isSelected]) && ([(UIButton*)[self.view viewWithTag:5] isSelected] || [(UIButton*)[self.view viewWithTag:6] isSelected])){
        
        if ([(UIButton*)[self.view viewWithTag:5] isSelected]){
            [(UIButton*)[self.view viewWithTag:5] setSelected:![(UIButton*)[self.view viewWithTag:5] isSelected]];
            [self toggleButtonStatesString:5];
        }
        
        if ([(UIButton*)[self.view viewWithTag:6] isSelected]){
            [(UIButton*)[self.view viewWithTag:6] setSelected:![(UIButton*)[self.view viewWithTag:6] isSelected]];
            [self toggleButtonStatesString:6];
        }
        
    }
/*    if (([sender tag]==5 || [sender tag]==6) && ![(UIButton*)[self.view viewWithTag:4] isSelected]){
        [(UIButton*)[self.view viewWithTag:4] setSelected:![(UIButton*)[self.view viewWithTag:4] isSelected]];
        [self toggleButtonStatesString:4];
    }
  */
    
    
    [self.delegate updateLiverReport:self.ButtonStates segueName:self.segueName];
}

- (IBAction)tfSizeChanged:(UITextField *)sender {
    //need to update ButtonStates string in between appropriate ||'s
    NSMutableArray *tmp = [[NSMutableArray alloc]init];//[self.ButtonStates componentsSeparatedByString:@"|"].mutableCopy;
    switch ([sender tag]) {
        case 16:
            if (sender.text.length>0){
                if ([sender.text characterAtIndex:0]!='0' && [sender.text characterAtIndex:0]!='.'){
                    if (![(UIButton*) [self.view viewWithTag:1] isSelected]){
                        [(UIButton*)[self.view viewWithTag:1] setSelected:YES];
                        [self toggleButtonStatesString:1];
                    }
                }
            }
            tmp = [self.ButtonStates componentsSeparatedByString:@"|"].mutableCopy;
            tmp[1]=sender.text;
            break;
        case 17:
            if (sender.text.length>0){
                if ([sender.text characterAtIndex:0]!='0' && [sender.text characterAtIndex:0]!='.'){
                    if (![(UIButton*) [self.view viewWithTag:4] isSelected]){
                        [(UIButton*)[self.view viewWithTag:4] setSelected:YES];
                        [self toggleButtonStatesString:4];
                    }
                }
            }
            tmp = [self.ButtonStates componentsSeparatedByString:@"|"].mutableCopy;
            tmp[2]=sender.text;
            break;
        case 18:
            if (sender.text.length>0){
                if ([sender.text characterAtIndex:0]!='0' && [sender.text characterAtIndex:0]!='.'){
                    if (![(UIButton*) [self.view viewWithTag:7] isSelected]){
                        [(UIButton*)[self.view viewWithTag:7] setSelected:YES];
                        [self toggleButtonStatesString:7];
                    }
                }
            }
            tmp = [self.ButtonStates componentsSeparatedByString:@"|"].mutableCopy;
            tmp[3]=sender.text;
           break;
            
        default:
            break;
    }
    self.ButtonStates=[tmp componentsJoinedByString:@"|"].mutableCopy;
    [self.delegate updateLiverReport:self.ButtonStates segueName:self.segueName];

}

- (IBAction)dismissKeyboard:(UIControl *)sender {
    [self.tfCystSize resignFirstResponder];
    [self.tfHemangiomaSize resignFirstResponder];
    [self.tfMassSize resignFirstResponder];

}



-(void)cancelNumberPad{
    [self resignFirstResponder];
    //numberTextField.text = @"";
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard = self.tfCystSize.text;
    [self.tfCystSize resignFirstResponder];
    [self.tfHemangiomaSize resignFirstResponder];
    [self.tfMassSize resignFirstResponder];

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableCharacterSet *myNumberSet = [[NSMutableCharacterSet alloc] init];
    if ([textField.text rangeOfString:@"."].location==NSNotFound){
        myNumberSet = [NSMutableCharacterSet characterSetWithCharactersInString:@"."];
        [myNumberSet formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    } else {
        myNumberSet = [NSCharacterSet decimalDigitCharacterSet];
    }
    NSCharacterSet *nonNumberSet = [myNumberSet invertedSet];
    
   // NSLog(@"change chars in tfsize");
    
    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
}

@end
