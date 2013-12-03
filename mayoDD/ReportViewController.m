//
//  ReportViewController.m
//  mayoDD
//
//  Created by Brian Goss on 11/15/13.
//
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

- (IBAction)sendString:(id)sender {
    //if (strTypeThis.length==0) return;

    [rscMgr sendString:self.reportString];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"Report String inside a ReportViewController: %@",self.reportString);
    rscMgr = (myRscMgr*)[myRscMgr sharedInstance];

}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.tvReport.text=self.reportString;
    [self.tvReport setNeedsDisplay];
    [self.tvReport setDelegate:self];
    rscMgr = (myRscMgr*)[myRscMgr sharedInstance];
    [self textViewDidChange:self.tvReport];
    //[self.parentViewController.navigationController.navigationBar setTranslucent:NO];
    //[self.view bringSubviewToFront:self.tvReport];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
    
    
    
    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
}

- (void)textViewDidChange:(UITextView *)textView {
    float fs=0;
    fs=[self sizeFontToFit:self.reportString minSize:1 maxSize:30 uitv:self.tvReport];
    self.lblReport.font = [self.lblReport.font fontWithSize:fs];
}

-(float)sizeFontToFit:(NSString*)aString minSize:(float)aMinFontSize maxSize:(float)aMaxFontSize uitv:(UITextView*) uitv
{
    float fudgeFactor = 64;
    float fontSize = aMaxFontSize;
    
    
    uitv.font = [uitv.font fontWithSize:fontSize];
    
    CGSize tallerSize = CGSizeMake(uitv.frame.size.width-fudgeFactor, 999);
    CGSize stringSize = [aString sizeWithFont:uitv.font constrainedToSize:tallerSize lineBreakMode:UILineBreakModeWordWrap];
    
    while (stringSize.height >= uitv.frame.size.height)
    {
        if (fontSize <= aMinFontSize) // it just won't fit
            return aMinFontSize;
        
        fontSize -= 0.125;
        uitv.font = [uitv.font fontWithSize:fontSize];
        tallerSize = CGSizeMake(uitv.frame.size.width-fudgeFactor,999);
        stringSize = [aString sizeWithFont:uitv.font constrainedToSize:tallerSize lineBreakMode:UILineBreakModeWordWrap];
        //   NSLog(@"font size: %f",fontSize);
    }
    //    NSLog(@"font size: %f",fontSize);
    
    
    return fontSize;
}


@end
