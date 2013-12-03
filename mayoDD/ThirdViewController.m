//
//  ThirdViewController.m
//  mayoDD
//
//  Created by Brian Goss on 10/29/13.
//
//

#import "ThirdViewController.h"
#import "SecondViewController.h"
//#import "myRscMgr.h"


@interface ThirdViewController ()

@end


@implementation ThirdViewController
NSMutableString *reportDataStr;// = [[NSMutableString alloc] init];
NSMutableString *reportImpStr;// = [[NSMutableString alloc] init];
NSMutableString *reportFullStr;// = [[NSMutableString alloc] init];

@synthesize bPatentR;
@synthesize bPatentL;
@synthesize bCephL;
@synthesize bCephR;
@synthesize reportView;

@synthesize tfCCAR;
@synthesize tfICAPSVR;
@synthesize tfICAEDVR;
@synthesize tfECAR;
@synthesize tfICARatioR;

@synthesize tfCCAL;
@synthesize tfICAPSVL;
@synthesize tfICAEDVL;
@synthesize tfECAL;
@synthesize tfICARatioL;

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
    //[rscMgr myInit];
    
//    [rscMgr setDelegate:self];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[BBIconLabel setTextToIconMap:[NSDictionary dictionaryWithObjectsAndKeys: FAIconRemove, "#IL1", nil]];
    rscMgr = (myRscMgr*)[myRscMgr sharedInstance];
    //[rscMgr setDelegate:self];
    
//    rscMgr = [[RscMgr alloc] init];
//    [rscMgr setDelegate:self];
//    
//    [rscMgr open];
//    [rscMgr setBaud:9600];
//    [self setTxMode:YES];

//    begin=0;
 //   chunkSize=64;
//    end=0;
    
//    [bPatentR setSelected:YES];
//    [bPatentR setHighlighted:NO];
//    [bPatentL setSelected:YES];
//    [bPatentL setHighlighted:NO];
    
    [reportView setDelegate:self];
    
    [  tfCCAR setDelegate:self];
    [  tfICAPSVR setDelegate:self];
    [  tfICAEDVR setDelegate:self];
    [  tfECAR setDelegate:self];
    [  tfICARatioR setDelegate:self];
    
    [  tfCCAL setDelegate:self];
    [  tfICAPSVL setDelegate:self];
    [  tfICAEDVL setDelegate:self];
    [  tfECAL setDelegate:self];
    [  tfICARatioL setDelegate:self];
    
    reportDataStr = [[NSMutableString alloc] initWithString:@"Hi\nBob"];
    reportImpStr = [[NSMutableString alloc] initWithString:@"Hi\nBob"];
    reportFullStr = [[NSMutableString alloc] initWithString:@"Hi\nBob"];
    strTypeThis = @"Default String";
    
    [self updateReport:Nil];
    [self textViewDidChange:self.reportView];
    
    
    //ThirdViewController *tvc=[vca objectAtIndex:2];
    
    
    //[[[self.tabBarController viewControllers] objectAtIndex:2] setBadgeValue:@"hi"];
    
}
//- (void) cableConnected:(NSString *)protocol{
//    [rscMgr open];
//    [rscMgr setBaud:9600];
//    [self setTxMode:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) cableDisconnected{
//    //  [rscMgr end];
//}

//- (void) portStatusChanged {
//    
//    for (long k=0; k<LONG_MAX/50; k++){
//        if (YES==NO) ;
//        
//    }
//    int modemStatus = [rscMgr getModemStatus];
//	static serialPortStatus portStat;
//    [rscMgr getPortStatus:&portStat];
//    
//    int bytesToWrite=0;
//    
//    
//    
//    if (end > 0){
//        //ie, if something left to write
//        //        [self sendString:NULL];
//        if (portStat.txAck>0){ //if ready to write more
//            if (begin+chunkSize<end && begin+chunkSize<BUFFER_LEN){
//                // if we can write a whole chunk, do it
//                bytesToWrite = chunkSize;
//                int bytesWritten = [rscMgr write:txBuffer+begin Length:chunkSize];
//                begin+=chunkSize;
//            } else {
//                //if there's not a whole chunk left to write, just write the last bit and reset
//                bytesToWrite = end-begin;
//                int bytesWritten = [rscMgr write:txBuffer+begin Length:bytesToWrite];
//               // serialView.text=[serialView.text stringByAppendingString:self.textEntry.text];
//
//                strTypeThis = @"";
//                begin=0;
//                end=0;
//            }
//        }
//        return;
//    } else {
//        //end==0, so nothing left to write
//        return;
//    }
//    
//    
//    
//}
//
//- (void) readBytesAvailable:(UInt32)numBytes{
//    int bytesRead = [rscMgr read:rxBuffer Length:numBytes];
//    NSString *incoming = [[NSString alloc] initWithBytes:rxBuffer length:bytesRead encoding:NSUTF8StringEncoding ];
//    
//    
//    NSLog(@"Read %d bytes from serial cable.",bytesRead);
//    
////    self.serialView.text=[self.serialView.text stringByAppendingString:[@"\n" stringByAppendingString:incoming] ];
////    [serialView scrollRangeToVisible:NSMakeRange(serialView.text.length, 0)];
////    
//}
//
//- (void) didReceivePortConfig {
//    
//}


- (void)sendString:(NSString *) strToSend {
    [rscMgr sendString:strTypeThis];
    return;
//    
//    begin=0;
//    //if (strToSend.length==0) return;
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
//   // strTypeThis=@"Hello, World2!";
//    NSString *text = strTypeThis;
//    if (begin == 0){
//        //need to check for buffer overflow here
//        for (int i=0; i<text.length;i++){
//            txBuffer[i]=(int)[text characterAtIndex:i];
//        }
//        
//        end=text.length;
//    }
//    if (portStat.txAck>0||begin==0){//assume ready to write if 1st time writing
//        if (begin+chunkSize<end && end >0 && begin+chunkSize<BUFFER_LEN){
//            bytesToWrite = chunkSize;
//            int bytesWritten = [rscMgr write:txBuffer+begin Length:chunkSize];
//            begin+=chunkSize;
//            NSLog(strTypeThis);
//        } else {
//            bytesToWrite = end-begin;
//            int bytesWritten = [rscMgr write:txBuffer+begin Length:bytesToWrite];
//            NSLog(strTypeThis);
//
//            strTypeThis=@"";
//            begin=0;
//            end=0;
//        }
//    }
    
    
}

//- (IBAction)sendString:(id) sender{
//    begin=0;
//    end=0;
//    if (strTypeThis.length==0) return;
//    NSLog(@"sendString: %@",strTypeThis);
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
//    if (begin == 0){
//        //need to check for buffer overflow here
//        for (int i=0; i<text.length;i++){
//            txBuffer[i]=(int)[text characterAtIndex:i];
//        }
//        
//        end=text.length;
//    }
//    if (portStat.txAck>0||begin==0){//assume ready to write if 1st time writing
//        if (begin+chunkSize<end && end >0 && begin+chunkSize<BUFFER_LEN){
//            bytesToWrite = chunkSize;
//            int bytesWritten = [rscMgr write:txBuffer+begin Length:chunkSize];
//            begin+=chunkSize;
//        } else {
//            bytesToWrite = end-begin;
//            int bytesWritten = [rscMgr write:txBuffer+begin Length:bytesToWrite];
//            strTypeThis=@"";
//            begin=0;
//            end=0;
//            NSLog(@"hi, that's weird");
//        }
//    }
//    
//    
//}

//- (void)setTxMode:(BOOL)on
//{
//    serialPortConfig portCfg;
//	[rscMgr getPortConfig:&portCfg];
//    
//    if(on == YES)
//    {
//        if(portCfg.txAckSetting == 1) return;
//        portCfg.txAckSetting = 1;
//    }
//    else
//    {
//        if(portCfg.txAckSetting == 0) return;
//        portCfg.txAckSetting = 0;
//    }
//    
//    [rscMgr setPortConfig:&portCfg requestStatus: NO];
//    
//}
//
//- (BOOL)getTxMode
//{
//    serialPortConfig portCfg;
//	[rscMgr getPortConfig:&portCfg];
//    
//    if(portCfg.txAckSetting == 1) return YES;
//    else return NO;
//    
//}
//



-(IBAction)radioClicked:sender{
    [sender setHighlighted:NO];
    [self updateReport:sender];
}
-(IBAction)buttonPressed:(id)sender{
    [sender setSelected:![sender isSelected]];
    [self updateReport:sender];
    //[self sendString:strTypeThis];
}
-(IBAction)typeReport:(id) sender{
    NSLog(@"%@,%d",strTypeThis,strTypeThis.length);
    [self updateReport:sender];
    [self sendString:strTypeThis];
}
-(IBAction)updateReport:(id)sender{
    NSString* strICAR, *strICAL, *strCCAR, *strCCAL, *strECAR, *strECAL, *strVertR, *strVertL;
    
    [reportDataStr setString:@""];
    [reportImpStr setString:@"\nIMPRESSION:\nRIGHT: Doppler evalution demonstrates "];
    [reportFullStr setString:@""];
    
    [reportDataStr appendString:@"VELOCITIES (cm/sec)\nRIGHT:\nCCA *psv: "];
    [reportDataStr appendString:tfCCAR.text];
    [reportDataStr appendString:@" cm/sec"];
    [reportDataStr appendString:@"\nICA psv: "];
    [reportDataStr appendString:tfICAPSVR.text];
    [reportDataStr appendString:@" cm/sec\nICA edv: "];
    [reportDataStr appendString:tfICAEDVR.text];
    [reportDataStr appendString:@" cm/sec\nECA: "];
    [reportDataStr appendString:tfECAR.text];
    [reportDataStr appendString:@" cm/sec\nICA/CCA: "];
    [reportDataStr appendString:tfICARatioR.text];
    [reportDataStr appendString:@" cm/sec\n"];
    [reportDataStr appendString:@"Vert: "];
    if (bPatentR.isSelected == NO) {
        [reportDataStr appendString:@"Patent."];
        if (bCephR.isSelected == NO){
            [reportDataStr appendString:@" Cephalad flow.\n\n"];
        } else [reportDataStr appendString:@" Reversed flow.\n\n"];
    } else {
        [reportDataStr appendString:@"Occluded.\n\n"];
    }
    
    [reportDataStr appendString:@"LEFT:\nCCA *psv: "];
    [reportDataStr appendString:tfCCAL.text];
    [reportDataStr appendString:@" cm/sec\nICA psv: "];
    [reportDataStr appendString:tfICAPSVL.text];
    [reportDataStr appendString:@" cm/sec\nICA edv: "];
    [reportDataStr appendString:tfICAEDVL.text];
    [reportDataStr appendString:@" cm/sec\nECA: "];
    [reportDataStr appendString:tfECAL.text];
    [reportDataStr appendString:@" cm/sec\nICA/CCA: "];
    [reportDataStr appendString:tfICARatioL.text];
    [reportDataStr appendString:@" cm/sec\n"];
    [reportDataStr appendString:@"Vert: "];
    if (bPatentL.isSelected == NO) {
        [reportDataStr appendString:@"Patent."];
        if (bCephL.isSelected == NO){
            [reportDataStr appendString:@" Cephalad flow.\n"];
        } else [reportDataStr appendString:@" Reversed flow.\n"];
    } else {
        [reportDataStr appendString:@"Occluded.\n"];
    }

    
    if ([tfICAPSVR.text floatValue] == 0) {
        strICAR=@"ICA occlusion.";
    } else if ([tfICAPSVR.text floatValue] > 229.99999) {
        strICAR=@"significant ICA stenosis greater than 70%.";
    } else if ([tfICAPSVR.text floatValue] > 129.9999){
        strICAR=@"significant ICA stenosis in the 50-69% range.";
    } else if ([tfICAPSVR.text floatValue] > 129.9999){
        strICAR=@"no significant ICA stenosis.";
    }
    
    if ([tfECAR.text floatValue]>200){
        strECAR=@"ECA velocities are elevated consistent with stenosis.";
    } else strECAR=@"No significant ECA stenosis.";
    
    
    if ([tfCCAR.text floatValue]>200){
        strCCAR=@"CCA velocities are elevated consistent with stenosis.";
    } else strCCAR=@"No significant CCA stenosis.";
    
    
    if (bPatentR.isSelected == NO) {
        strVertR=@"Patent vertebral artery with";
        if (bCephR.isSelected == NO){
            strVertR=[strVertR stringByAppendingString:@" cephalad flow."];
        } else strVertR=[strVertR stringByAppendingString:@" reversed flow."];
    } else {
        strVertR=@"Occluded vertebral artery.";
    }
    
    
    
    if ([tfICAPSVL.text floatValue] == 0) {
        strICAL=@"ICA occlusion.";
    } else if ([tfICAPSVL.text floatValue] > 229.99999) {
        strICAL=@"significant ICA stenosis greater than 70%.";
    } else if ([tfICAPSVL.text floatValue] > 129.9999){
        strICAL=@"significant ICA stenosis in the 50-69% range.";
    } else if ([tfICAPSVL.text floatValue] > 129.9999){
        strICAL=@"no significant ICA stenosis.";
    }
    
    if ([tfECAL.text floatValue]>200){
        strECAL=@"ECA velocities are elevated consistent with stenosis.";
    } else strECAL=@"No significant ECA stenosis.";
    
    
    if ([tfCCAL.text floatValue]>200){
        strCCAL=@"CCA velocities are elevated consistent with stenosis.";
    } else strCCAL=@"No significant CCA stenosis.";
    

    if (bPatentL.isSelected == NO) {
        strVertL=@"Patent vertebral artery with";
        if (bCephL.isSelected == NO){
            strVertL=[strVertL stringByAppendingString:@" cephalad flow."];
        } else strVertL=[strVertL stringByAppendingString:@" reversed flow."];
    } else {
        strVertL=@"Occluded.";
    }
    
    
    
    
    
    //string = [[NSArray arrayWithObjects:@"This", "Is", "A", "Test", nil] componentsJoinedByString:@" "];
    
    [reportImpStr appendString:[[NSArray arrayWithObjects:strICAR, strECAR, strCCAR, strVertR, @"\n\nLEFT: Doppler evaluation demonstrates", strICAL,strECAL,strCCAL, strVertL, nil] componentsJoinedByString:@" "]];
    [reportFullStr appendString:reportDataStr];
    [reportFullStr appendString:reportImpStr];
    
    
    reportView.text=reportFullStr;
 //   [self sizeFontToFit:reportFullStr minSize:1 maxSize:30 uitv:reportView];
    [self textViewDidChange:self.reportView];
    strTypeThis=reportFullStr;
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
    [self sizeFontToFit:reportFullStr minSize:1 maxSize:30 uitv:reportView];
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
     //   NSLog(@"font size: %f",fontSize);
    }
    NSLog(@"font size: %f",fontSize);

    return YES;
}




@end
