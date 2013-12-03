//
//  ViewController.m
//  mayoDD
//
//  Created by bcg2 on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ThirdViewController.h"
#import "AppDelegate.h"
//#import "myRscMgr.h"
//#import "RscMgr.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize touchAreaView;
@synthesize textEntry;
@synthesize sendButton;
@synthesize serialView;

- (void)viewDidLoad
{
    [super viewDidLoad];
     rscMgr = (myRscMgr*)[myRscMgr sharedInstance];
    self.textEntry.delegate=self;
    //[rscMgr myInit];
    //[rscMgr setDelegate:self];
    //rscMgr = [[RscMgr alloc] init];
    //[rscMgr setDelegate:self];
	// Do any additional setup after loading the view, typically from a nib.
    begin=0;
    chunkSize=64;
    
//    NSArray *vca=[self.tabBarController viewControllers];
//    ThirdViewController *tvc=[vca objectAtIndex:2];
//    //[[[self.tabBarController viewControllers] objectAtIndex:2] setBadgeValue:@"7"];
//    
//    tvc.tfCCAR.text=@"007";
    
    
    
    
    
    
    
    
    //Taps
    UITapGestureRecognizer *tapRecognizer;
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundTap:)];
    tapRecognizer.numberOfTapsRequired=1;
    tapRecognizer.numberOfTouchesRequired=1;
    
    //double tap
    UITapGestureRecognizer *tapDoubleRecognizer;
    tapDoubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foundDoubleTap:)];
    tapDoubleRecognizer.numberOfTapsRequired=2;
    tapDoubleRecognizer.numberOfTouchesRequired=1;
    [touchAreaView addGestureRecognizer:tapDoubleRecognizer];
    
    [tapRecognizer requireGestureRecognizerToFail:tapDoubleRecognizer];
    [touchAreaView addGestureRecognizer:tapRecognizer];

    
    //pan
    UIPanGestureRecognizer *panRecognizer1F;
    panRecognizer1F = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(foundPan1F:)];
    panRecognizer1F.maximumNumberOfTouches=1;
    [touchAreaView addGestureRecognizer:panRecognizer1F];
    UIPanGestureRecognizer *panRecognizer2F;
    panRecognizer2F = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(foundPan2F:)];
    panRecognizer2F.minimumNumberOfTouches=2;
    panRecognizer2F.maximumNumberOfTouches=2;
    
    [touchAreaView addGestureRecognizer:panRecognizer2F];
    //Pinches
    UIPinchGestureRecognizer *pinchRecognizer;
    pinchRecognizer =[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(foundPinch:)];
    [touchAreaView addGestureRecognizer:pinchRecognizer];
    
}

//- (void) cableConnected:(NSString *)protocol{
//    [rscMgr open];
//    [rscMgr setBaud:9600];
//    [rscMgr setTxMode:YES];
//}
//
//- (void) cableDisconnected{
//     // [rscMgr release];
//}
//
//- (void) portStatusChanged {
//    for (long k=0; k<LONG_MAX/100; k++){
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
////        [self sendString:NULL];
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
//                serialView.text=[serialView.text stringByAppendingString:self.textEntry.text];
//                self.textEntry.text = @"";
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
//
//
//- (void) readBytesAvailable:(UInt32)numBytes{
//    int bytesRead = [rscMgr read:rxBuffer Length:numBytes];
//    NSString *incoming = [[NSString alloc] initWithBytes:rxBuffer length:bytesRead encoding:NSUTF8StringEncoding ];
//                          
//    
//    NSLog(@"Read %d bytes from serial cable.",bytesRead);
//    
//   self.serialView.text=[self.serialView.text stringByAppendingString:[@"\n" stringByAppendingString:incoming] ];
//    [serialView scrollRangeToVisible:NSMakeRange(serialView.text.length, 0)];
//
//}
//
//- (void) didReceivePortConfig {
//    
//}
- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self sendString:Nil];
        return NO;
    }
    return YES;
}

- (void)viewDidUnload
{
    [self setSerialView:nil];
    [self setSendButton:nil];
    [self setTextEntry:nil];
    [self setTouchAreaView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
//duinoTalk
- (IBAction)sendString:(id)sender {
    [self.textEntry resignFirstResponder];
    if (self.textEntry.text.length==0) return;
    [rscMgr sendString:self.textEntry.text];
    self.serialView.text=self.textEntry.text;
    self.textEntry.text=@"";
    
    
//    for (long k=0; k<LONG_MAX/100; k++){
//        if (YES==NO) ;
//        
//    }
//    [self.textEntry resignFirstResponder];
//    int modemStatus = [rscMgr getModemStatus];
//	static serialPortStatus portStat;
//    [rscMgr getPortStatus:&portStat];
//    
//    
//    int bytesToWrite=0;
//    
//    
//    NSString *text = self.textEntry.text;
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
//            self.textEntry.text = @"";
//            begin=0;
//            end=0;
//        }
//    }
    
    
}



- (void) sendKeyboardMouseCommand:(NSString *)command{
    command = command.uppercaseString;
    
    if ([command rangeOfString:@"@~leftMouseDown"].location == NSNotFound){
        int bytesToWrite = command.length;
        for (int i=0;i<bytesToWrite;i++){
            txBuffer[i] = (int)[command characterAtIndex:i];
        }
        int bytesWritten = [rscMgr write:txBuffer Length:bytesToWrite];
    } else {
        command=@"@~Nope";
        int bytesToWrite = command.length;
        for (int i=0;i<bytesToWrite;i++){
            txBuffer[i] = (int)[command characterAtIndex:i];
        }
        int bytesWritten = [rscMgr write:txBuffer Length:bytesToWrite];
    }
    
    // int bytesWritten = [rscMgr write(<#int#>, <#const void *#>, <#size_t#>)
    
}
//touchAreaView stuff
- (void) foundTap:(UITapGestureRecognizer *)recognizer{
    NSString *cmd = @"@~leftMouseClick^";
    if (recognizer.state==UIGestureRecognizerStateEnded && begin==0){
        
        end=cmd.length;
        for (int i=0; i<end; i++){
            txBuffer[i]=(int)[cmd characterAtIndex:i];
        }
        for (long k=0; k<(LONG_MAX/100);k++){
            if (YES==NO) ;
        }
        int bytesWritten =[rscMgr write:txBuffer Length:end];
        
        
        
        serialView.text=[serialView.text stringByAppendingString:@"Tapped\n"];
        [serialView scrollRangeToVisible:NSMakeRange([serialView.text length], 0)];
    }
    
}
- (void) foundPan1F:(UIPanGestureRecognizer *)recognizer{
    NSString *cmd = [[NSString alloc]init];
    int deltaE=7;
    float invDelay = 2000;
    cmd=@"@~^";
    
    
    CGPoint delta = [recognizer translationInView:[recognizer view]];
    [recognizer setTranslation:CGPointZero inView:[recognizer view]];
    
    if (recognizer.state == UIGestureRecognizerStateChanged){
        if (delta.x > deltaE){
            cmd=@"@~moveMouseR^";
        } else if (delta.x<0-deltaE){
            cmd=@"@~moveMouseL^";
        }
        
        end=cmd.length;
        for (int i=0; i<end; i++){
            txBuffer[i]=(int)[cmd characterAtIndex:i];
        }
        for (long k=0; k<(LONG_MAX/invDelay);k++){
            if (YES==NO) ;
        }
        
        int bytesWritten =[rscMgr write:txBuffer Length:end];
        
        
        
        if (delta.y > deltaE){
            cmd=@"@~moveMouseD^";
        }  else if (delta.y<0-deltaE){
            cmd=@"@~moveMouseU^";
        }
        
        
        end=cmd.length;
        for (int i=0; i<end; i++){
            txBuffer[i]=(int)[cmd characterAtIndex:i];
        }
        for (long k=0; k<(LONG_MAX/invDelay);k++){
            if (YES==NO) ;
        }
        
        bytesWritten =[rscMgr write:txBuffer Length:end];
        
        
        serialView.text=[serialView.text stringByAppendingString:@"One Finger Pan\n"];
        [serialView scrollRangeToVisible:NSMakeRange([serialView.text length], 0)];
        [serialView setNeedsDisplay];
    }
    
    
}
- (void) foundPan2F:(UIPanGestureRecognizer *)recognizer{
    
    
    serialView.text=[serialView.text stringByAppendingString:@"Two Finger Pan\n"];
    [serialView scrollRangeToVisible:NSMakeRange([serialView.text length], 0)];
    
    
}
- (void) foundDoubleTap:(UITapGestureRecognizer *)recognizer{
    NSString *cmd = @"@~doubleLeftMouseClick^";
    if (recognizer.state==UIGestureRecognizerStateEnded && begin==0){
        
        end=cmd.length;
        for (int i=0; i<end; i++){
            txBuffer[i]=(int)[cmd characterAtIndex:i];
        }
        for (long k=0; k<(LONG_MAX/100);k++){
            if (YES==NO) ;
        }
        int bytesWritten =[rscMgr write:txBuffer Length:end];
        
        serialView.text=[serialView.text stringByAppendingString:@"Double Tapped\n"];
        [serialView scrollRangeToVisible:NSMakeRange([serialView.text length], 0)];
    }
}

- (void) foundPinch:(UIPinchGestureRecognizer *)recognizer{
    //    serialView.text= [serialView.text stringByAppendingString:@"Pinched\n"];
    //    serialView.text = [serialView.text stringByAppendingString:recognizer.state];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        serialView.text = [serialView.text stringByAppendingString:@"Pinch Began\n"];
        [self sendKeyboardMouseCommand:@"@~Ctrl^"];
        [NSThread sleepForTimeInterval:.05];
        [self sendKeyboardMouseCommand:@"@~Alt^"];
        [NSThread sleepForTimeInterval:.05];
        [self sendKeyboardMouseCommand:@"@~Z^"];
        [NSThread sleepForTimeInterval:.05];
        [self sendKeyboardMouseCommand:@"@~HandsOffKeyboard^"];
        [NSThread sleepForTimeInterval:.05];
        [self sendKeyboardMouseCommand:@"@~leftMouseDown^"];
        [NSThread sleepForTimeInterval:.05];
        
    }
    if (recognizer.state == UIGestureRecognizerStateChanged){
        serialView.text = [serialView.text stringByAppendingString:@"...pinching...\n"];
        [NSThread sleepForTimeInterval:.02];
        
    }
    if(recognizer.state == UIGestureRecognizerStateEnded){
        serialView.text = [serialView.text stringByAppendingString:@"Pinch Ended\n"];
        [NSThread sleepForTimeInterval:.02];
        
    }
    
    [serialView scrollRangeToVisible:NSMakeRange([serialView.text length], 0)];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

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


@end
