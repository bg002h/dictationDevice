//
//  SecondViewController.m
//  mayoDD
//
//  Created by Brian Goss on 10/28/13.
//
//

#import "SecondViewController.h"
#import "myRscMgr.h"

//NSString *strTypeThis=@"Default String";
@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize reportView;

@synthesize scCFVR;
@synthesize scPFVR;
@synthesize scFVR;
@synthesize scPOPR;
@synthesize scPTVR;
@synthesize scPERR;
@synthesize scCystR;

@synthesize scCFVL;
@synthesize scPFVL;
@synthesize scFVL;
@synthesize scPOPL;
@synthesize scPTVL;
@synthesize scPERL;
@synthesize scCystL;

@synthesize strTypeThis;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    rscMgr = (myRscMgr*)[myRscMgr sharedInstance];
//    [rscMgr setDelegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [reportView setDelegate:self];
    
//    rscMgr = [[RscMgr alloc] init];
//    [rscMgr setDelegate:self];
//    txBuffer[0]='q';
    
   // int bytesWritten = [rscMgr write:txBuffer+begin Length:1];

    begins=0;
    chunkSize=64;
    
    strTypeThis = @"Default String";
    
    [self updateReport:Nil];
    [self sizeFontToFit:reportView.text minSize:1 maxSize:30 uitv:reportView];

    //[scCFVR addTarget:self action:@selector(updateReport:) forControlEvents:UIControlEventValueChanged];
    
    
    
	// Do any additional setup after loading the view.
}


-(IBAction)typeReport:(id) sender{
 //   strTypeThis=@"Hello, World!";
    [self updateReport:sender];
   // NSLog(@"%@,%d",strTypeThis,strTypeThis.length);
    //p[[xx[self updateReport:sender];
    [self sendString:@"Hello, World!"];
}





//- (IBAction)updateTextView:(id)sender {
//}

-(IBAction)updateReport:(id)sender{
    //set the string strTypeThis
    NSMutableString* mstrTypeThis = [[NSMutableString alloc] initWithString:@""];
    NSMutableString* mstrTypeThisPrefix = [[NSMutableString alloc] initWithString:@""];
    NSMutableString* mstrShowThis = [[NSMutableString alloc] initWithString:@""];
    
    NSString* strCFVR = @"common femoral vein";
    NSString* strPFVR = @"upper deep femoral vein";
    NSString* strFVR = @"femoral vein";
    NSString* strPOPR = @"popliteal vein";
    NSString* strPTVR = @"posterior tibial vein";
    NSString* strPERR =@"peroneal veins";
    NSString* strCystR=@"";
    NSMutableString* negR=[[NSMutableString alloc]initWithString:@"No evidence of thrombus in the widely patent and compressible"];
    NSMutableString* acuteR=[[NSMutableString alloc]initWithString:@"There is acute occlusive or nearly occlusive non-compressible deep venous thrombus expanding the"];
    NSMutableString* chronicR=[[NSMutableString alloc]initWithString:@"There are chronic changes of prior deep venous thrombus including irregular mural thickening or webbing involving the"];
    
    NSString* strCFVL = @"common femoral vein";
    NSString* strPFVL = @"upper deep femoral vein";
    NSString* strFVL = @"femoral vein";
    NSString* strPOPL = @"popliteal vein";
    NSString* strPTVL = @"posterior tibial vein";
    NSString* strPERL =@"peroneal veins";
    NSString* strCystL=@"";
    NSMutableString* negL=[[NSMutableString alloc] initWithString:@"No evidence of thrombus in the widely patent and compressible"];
    NSMutableString* acuteL=[[NSMutableString alloc] initWithString:@"There is acute occlusive or nearly occlusive non-compressible deep venous thrombus expanding the"];
    NSMutableString* chronicL=[[NSMutableString alloc] initWithString:@"There are chronic changes of prior deep venous thrombus including irregular mural thickening or webbing involving the"];
    int setCount=0;
    
    
    NSArray* outletsR = [NSArray arrayWithObjects:scCFVR, scPFVR, scFVR, scPOPR, scPTVR, scPERR, nil];
    NSArray* stringsR =[NSArray arrayWithObjects:strCFVR, strPFVR, strFVR, strPOPR, strPTVR, strPERR, nil];
    NSDictionary *dictR = [NSDictionary dictionaryWithObjects:outletsR forKeys:stringsR];
    
    
    NSArray* outletsL = [NSArray arrayWithObjects: scCFVL, scPFVL, scFVL, scPOPL, scPTVL, scPERL, nil];
    NSArray* stringsL =[NSArray arrayWithObjects: strCFVL, strPFVL, strFVL, strPOPL, strPTVL, strPERL, nil];
    NSDictionary *dictL = [NSDictionary dictionaryWithObjects:outletsL forKeys:stringsL];
    
    
    
    NSMutableArray* negOutletsR=[[NSMutableArray alloc] init];
    NSMutableArray* acuteOutletsR=[[NSMutableArray alloc] init];
    NSMutableArray* chronicOutletsR=[[NSMutableArray alloc] init];
    NSMutableArray* negOutletsL=[[NSMutableArray alloc] init];
    NSMutableArray* acuteOutletsL=[[NSMutableArray alloc] init];
    NSMutableArray* chronicOutletsL=[[NSMutableArray alloc] init];
    
    NSMutableArray* allStringsR = [[NSMutableArray alloc]initWithObjects:acuteR, chronicR, negR, nil];
    NSMutableArray* allStringsL = [[NSMutableArray alloc]initWithObjects:acuteL, chronicL, negL, nil];
    NSMutableArray* posStringsR = [[NSMutableArray alloc] initWithObjects: nil];
    NSMutableArray* posStringsL = [[NSMutableArray alloc] initWithObjects: nil];
    

    NSMutableArray* reportStrings = [[NSMutableArray alloc]init];

    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatterTOD = [[NSDateFormatter alloc]init];
    NSDateFormatter *dateFormatterDMY = [[NSDateFormatter alloc]init];
    [dateFormatterTOD setDateFormat:@"HH:mm"];
    [dateFormatterDMY setDateFormat:@"MM/dd/YYYY"];
    NSString *dateStringTOD = [dateFormatterTOD stringFromDate:currDate];
    NSString *dateStringDMY = [dateFormatterDMY stringFromDate:currDate];
    //NSLog(@"%@",dateString);
    
//    NSDate* now = [NSDate date];
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *dateComponents = [gregorian components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit  | NSMinuteCalendarUnit) fromDate:now];
//    NSInteger hour = [dateComponents hour];
//    NSInteger minute = [dateComponents minute];
//    NSInteger month = [dateComponents month];
//    NSInteger day = [dateComponents day];
    
    
    
    for (UISegmentedControl *sc in outletsR){
        //if (sc!=nil){
        if (sc.selectedSegmentIndex == 0){
            [negOutletsR addObject:sc];
        } else if (sc.selectedSegmentIndex==1) {
            [acuteOutletsR addObject:sc];
        } else if (sc.selectedSegmentIndex==2){
            [chronicOutletsR addObject:sc];
        }//}
    }
    
    for (UISegmentedControl *sc in outletsL){
        //if (sc!=nil){
        if (sc.selectedSegmentIndex == 0){
            [negOutletsL addObject:sc];
        } else if (sc.selectedSegmentIndex==1) {
            [acuteOutletsL addObject:sc];
        } else if (sc.selectedSegmentIndex==2){
            [chronicOutletsL addObject:sc];
        }//}
    }
    
    
    
    
    // [negR appendString:[negOutlets componentsJoinedByString:@", "]];
    
    //make the negative strings
    setCount=negOutletsR.count;
    int i=0;
    for (UISegmentedControl *sc in negOutletsR){
        //NSLog(@"SC key: %@",[dictR allKeysForObject:sc]);
        if (setCount>2){
            if (i==setCount-1){
                [negR appendString:@", and "];
            } else if (i>0){
                [negR appendString:@", "];
            } else {
                [negR appendString:@" "];
            }
        } else if (setCount>1){
            if (i>0){
                [negR appendString:@" and "];
            } else {
                [negR appendString:@" "];
            }
        } else if (setCount>0){
            [negR appendString:@" "];
        }
        
        [negR appendString:[dictR allKeysForObject:sc][0]];
        i++;
    }
    
    if (setCount>0){
        [negR appendString:@"."];
    } else {
        negR=[NSMutableString stringWithString:@""];
    }
    
   // NSLog(negR);
    
    setCount=negOutletsL.count;
    i=0;
    for (UISegmentedControl *sc in negOutletsL){
        //NSLog(@"SC key: %@",[dictR allKeysForObject:sc]);
        if (setCount>2){
            if (i==setCount-1){
                [negL appendString:@", and "];
            } else if (i>0){
                [negL appendString:@", "];
            } else {
                [negL appendString:@" "];
            }
        } else if (setCount>1){
            if (i>0){
                [negL appendString:@" and "];
            } else {
                [negL appendString:@" "];
            }
        } else if (setCount>0){
            [negL appendString:@" "];
        }
        
        [negL appendString:[dictL allKeysForObject:sc][0]];
        i++;
    }
    
    if (setCount>0){
        [negL appendString:@"."];
    } else {
        negL=[NSMutableString stringWithString:@""];
    }
    
  //  NSLog(negL);
    
    //make the acute strings
    
  //*******ACUTE*************************
    
    setCount=acuteOutletsR.count;
    i=0;
    for (UISegmentedControl *sc in acuteOutletsR){
        //NSLog(@"SC key: %@",[dictR allKeysForObject:sc]);
        if (setCount>2){
            if (i==setCount-1){
                [acuteR appendString:@", and "];
            } else if (i>0){
                [acuteR appendString:@", "];
            } else {
                [acuteR appendString:@" "];
            }
        } else if (setCount>1){
            if (i>0){
                [acuteR appendString:@" and "];
            } else {
                [acuteR appendString:@" "];
            }
        } else if (setCount>0){
            [acuteR appendString:@" "];
        }
        
        [acuteR appendString:[dictR allKeysForObject:sc][0]];
        i++;
    }
    
    if (setCount>0){
        [acuteR appendString:@"."];
    } else {
        acuteR=[NSMutableString stringWithString:@""];
    }
    
    //NSLog(acuteR);
    
    setCount=acuteOutletsL.count;
    i=0;
    for (UISegmentedControl *sc in acuteOutletsL){
        //NSLog(@"SC key: %@",[dictR allKeysForObject:sc]);
        if (setCount>2){
            if (i==setCount-1){
                [acuteL appendString:@", and "];
            } else if (i>0){
                [acuteL appendString:@", "];
            } else {
                [acuteL appendString:@" "];
            }
        } else if (setCount>1){
            if (i>0){
                [acuteL appendString:@" and "];
            } else {
                [acuteL appendString:@" "];
            }
        } else if (setCount>0){
            [acuteL appendString:@" "];
        }
        
        [acuteL appendString:[dictL allKeysForObject:sc][0]];
        i++;
    }
    
    if (setCount>0){
        [acuteL appendString:@"."];
    } else {
        acuteL=[NSMutableString stringWithString:@""];
    }
    
    //NSLog(acuteL);
    
    //make the acute strings
    
    //**********************END ACUTE
    
    //*******Chronic*************************
    
    setCount=chronicOutletsR.count;
    i=0;
    for (UISegmentedControl *sc in chronicOutletsR){
        //NSLog(@"SC key: %@",[dictR allKeysForObject:sc]);
        if (setCount>2){
            if (i==setCount-1){
                [chronicR appendString:@", and "];
            } else if (i>0){
                [chronicR appendString:@", "];
            } else {
                [chronicR appendString:@" "];
            }
        } else if (setCount>1){
            if (i>0){
                [chronicR appendString:@" and "];
            } else {
                [chronicR appendString:@" "];
            }
        } else if (setCount>0){
            [chronicR appendString:@" "];
        }
        
        [chronicR appendString:[dictR allKeysForObject:sc][0]];
        i++;
    }
    
    if (setCount>0){
        [chronicR appendString:@"."];
    } else {
        chronicR=[NSMutableString stringWithString:@""];
    }
    
   // NSLog(chronicR);
    
    setCount=chronicOutletsL.count;
    i=0;
    for (UISegmentedControl *sc in chronicOutletsL){
        //NSLog(@"SC key: %@",[dictR allKeysForObject:sc]);
        if (setCount>2){
            if (i==setCount-1){
                [chronicL appendString:@", and "];
            } else if (i>0){
                [chronicL appendString:@", "];
            } else {
                [chronicL appendString:@" "];
            }
        } else if (setCount>1){
            if (i>0){
                [chronicL appendString:@" and "];
            } else {
                [chronicL appendString:@" "];
            }
        } else if (setCount>0){
            [chronicL appendString:@" "];
        }
        
        [chronicL appendString:[dictL allKeysForObject:sc][0]];
        i++;
    }
    
    if (setCount>0){
        [chronicL appendString:@"."];
    } else {
        chronicL=[NSMutableString stringWithString:@""];
    }
    
   // NSLog(chronicL);
    
    //**********************END Chronic
    
    if (scCFVR.selectedSegmentIndex==1){
        strCFVR=@"1";
    }
    
    
//    [mstrTypeThis appendString:[[NSArray arrayWithObjects: @"RIGHT:", strCFVR, strPFVR, strFVR, strPOPR, strPTVR, strPERR, strCystR, @"\nLEFT:", strCFVL,strPFVL,strFVL, strPOPL, strPTVL, strPERL, strCystL, nil] componentsJoinedByString:@" "]];
    
    allStringsR = [[NSMutableArray alloc]initWithObjects:acuteR, chronicR, negR, nil];
    allStringsL = [[NSMutableArray alloc]initWithObjects:acuteL, chronicL, negL, nil];

    
    for (NSMutableString* s in allStringsR){
        if (s.length>0){
            [posStringsR addObject:s];
        }
    }
    for (NSMutableString* s in allStringsL){
        if (s.length>0){
            [posStringsL addObject:s];
        }
    }
    
    [mstrTypeThisPrefix appendString:@"EXAM: Bilateral Lower Extremity Venous Doppler Ultrasound\n\nCOMPARISON: []\n\nRIGHT: "];
    [mstrShowThis appendString:@"RIGHT: "];
    //[[NSArray arrayWithObjects:@"RIGHT:", nil] componentsJoinedByString:@" "]];
    [mstrTypeThis appendString:[posStringsR componentsJoinedByString:@" "]];
    [mstrTypeThis appendString:@"\n\nLEFT: "];
    [mstrTypeThis appendString:[posStringsL componentsJoinedByString:@" "]];
    
    if (acuteR.length>0 || acuteL.length>0){
        [mstrTypeThis appendString:@"\n\nFindings discussed with Dr. []  at "];//[] on []."];
        [mstrTypeThis appendString:[[NSArray arrayWithObjects:dateStringTOD, @"on", dateStringDMY, nil] componentsJoinedByString:@" "]];
        [mstrTypeThis appendString:@"."];
    
    }
    [mstrTypeThisPrefix appendString:mstrTypeThis];
    [mstrShowThis appendString:mstrTypeThis];
    mstrTypeThis=mstrTypeThisPrefix;
    
   // [mstrTypeThis appendString:[[NSArray arrayWithObjects:@"RIGHT: ", acuteR, chronicR, negR, @"\nLEFT: ", acuteL, chronicL, negL , nil] componentsJoinedByString:@" "]];
    
    strTypeThis=(NSString*)mstrTypeThis.copy;
    reportView.text=(NSString*)mstrShowThis.copy;
    //[self typeReport:sender];
    //NSLog(strTypeThis);
    
    [self sizeFontToFit:reportView.text minSize:10 maxSize:30 uitv:reportView];

}

//-(void) updateReport{
//
//}


- (void)sendString:(NSString *) strToSend {
    if (strTypeThis.length>0)
        [rscMgr sendString:strTypeThis];
    return;
//   // strTypeThis=@"hi world";
//    begins=0;
//    //    if (strToSend.length==0) return;
//    if (strTypeThis.length==0) return;
//    for (long k=0; k<LONG_MAX/100; k++){
//        if (YES==NO) ;
//        
//    }
//    //    [resignFirstResponder];
//    int modemStatus = [rscMgr getModemStatus];
//	static serialPortStatus portStat;
//    [rscMgr getPortStatus:&portStat];
//    
//    
//    int bytesToWrite=0;
//    
//    
//    NSString *text = strTypeThis;
//    if (begins == 0){
//        //need to check for buffer overflow here
//        for (int i=0; i<text.length;i++){
//            txBuffer[i]=(int)[text characterAtIndex:i];
//        }
//        
//        ends=text.length;
//    }
//    if (portStat.txAck>0||begins==0){//assume ready to write if 1st time writing
//        if (begins+chunkSize<ends && ends >0 && begins+chunkSize<BUFFER_LEN){
//            NSLog(text);
//            bytesToWrite = chunkSize;
//            int bytesWritten = [rscMgr write:txBuffer+begins Length:chunkSize];
//            begins+=chunkSize;
//        } else {
//            NSLog(text);
//
//            bytesToWrite = ends-begins;
//            int bytesWritten = [rscMgr write:txBuffer+begins Length:bytesToWrite];
//            strTypeThis=@"";
//            begins=0;
//            ends=0;
//        }
//    }
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

- (void)textViewDidChange:(UITextView *)textView {
    [self sizeFontToFit:reportView.text minSize:1 maxSize:30 uitv:reportView];
}


-(BOOL)sizeFontToFit:(NSString*)aString minSize:(float)aMinFontSize maxSize:(float)aMaxFontSize uitv:(UITextView*) uitv
{
    float fudgeFactor = 64;
    float fontSize = aMaxFontSize;
    
    
    uitv.font = [uitv.font fontWithSize:fontSize];
    
    CGSize tallerSize = CGSizeMake(uitv.frame.size.width-fudgeFactor, 999);
    CGSize stringSize = [aString sizeWithFont:uitv.font constrainedToSize:tallerSize lineBreakMode:UILineBreakModeWordWrap];
    
    while (stringSize.height >= uitv.frame.size.height)
    {
        if (fontSize <= aMinFontSize) // it just won't fit
            return NO;
        
        fontSize -= 0.125;
        uitv.font = [uitv.font fontWithSize:fontSize];
        tallerSize = CGSizeMake(uitv.frame.size.width-fudgeFactor,999);
        stringSize = [aString sizeWithFont:uitv.font constrainedToSize:tallerSize lineBreakMode:UILineBreakModeWordWrap];
      //  NSLog(@"font size: %f, stringSize.height: %f, uitv.frame.s.h: %f",fontSize, stringSize.height, uitv.frame.size.height);
    }
//    NSLog(@"font size: %f, stringSize.height: %f, uitv.frame.s.h: %f",fontSize, stringSize.height, uitv.frame.size.height);
    
    return YES;
}


@end
