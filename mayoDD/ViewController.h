//
//  ViewController.h
//  mayoDD
//
//  Created by bcg2 on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RscMgr.h"
#import "myRscMgr.h"

#define BUFFER_LEN 4096

@interface ViewController : UIViewController <UITextFieldDelegate> /*<RscMgrDelegate>*/{
    
    myRscMgr *rscMgr;
    UInt8 rxBuffer[BUFFER_LEN];
    UInt8 txBuffer[BUFFER_LEN];
    
    int begin;
    int chunkSize;
    int end;
//    IBOutlet UIView *touchAreaView;
}
@property (weak, nonatomic) IBOutlet UITextField *textEntry;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *serialView;
//@property (weak, nonatomic) IBOutlet UIView *touchAreaView;
@property (weak, nonatomic) IBOutlet UIView *touchAreaView;

- (IBAction)sendString:(id)sender;
- (void) sendKeyboardMouseCommand:(NSString *)command;
/*- (void)setTxMode:(BOOL)on;
- (BOOL)getTxMode;
*/

@end
