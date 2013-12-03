//
//  ThirdViewController.h
//  mayoDD
//
//  Created by Brian Goss on 10/29/13.
//
//

#import <UIKit/UIKit.h>
#import "RscMgr.h"
#import "myRscMgr.h"
#import "BButton.h"
#import "BBIconLabel.h"
#import "BRadioButton.h"
#import "FontAwesomeIcons.h"
#import "IcomoonFontIcons.h"
#import "TPKeyboardAvoidingScrollView.h"

#define BUFFER_LEN 4096

@interface ThirdViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate, RscMgrDelegate> {
    myRscMgr *rscMgr;
    UInt8 rxBuffer[BUFFER_LEN];
    UInt8 txBuffer[BUFFER_LEN];
    
    int begin;
    int chunkSize;
    int end;
    
}
    


@property (weak, nonatomic) IBOutlet UIButton *bPatentR;
@property (weak, nonatomic) IBOutlet UIButton *bPatentL;
@property (weak, nonatomic) IBOutlet UIButton *bCephR;
@property (weak, nonatomic) IBOutlet UIButton *bCephL;

@property BOOL* selectedBool;
@property (weak, nonatomic) IBOutlet UITextView *reportView;



@property (weak, nonatomic) IBOutlet UITextField *tfCCAR;
@property (weak, nonatomic) IBOutlet UITextField *tfICAPSVR;
@property (weak, nonatomic) IBOutlet UITextField *tfICAEDVR;
@property (weak, nonatomic) IBOutlet UITextField *tfECAR;
@property (weak, nonatomic) IBOutlet UITextField *tfICARatioR;

@property (weak, nonatomic) IBOutlet UITextField *tfCCAL;
@property (weak, nonatomic) IBOutlet UITextField *tfICAPSVL;
@property (weak, nonatomic) IBOutlet UITextField *tfICAEDVL;
@property (weak, nonatomic) IBOutlet UITextField *tfECAL;
@property (weak, nonatomic) IBOutlet UITextField *tfICARatioL;

@property (weak, nonatomic) NSString *strTypeThis;

- (IBAction)radioClicked:sender;
- (IBAction)buttonPressed:(id)sender;
- (IBAction) updateReport:sender;
- (IBAction)typeReport:(id) sender;

- (void)sendString:(NSString *)strToSend;
//-( IBAction)sendString:(id)sender;
- (void)setTxMode:(BOOL)on;
- (BOOL)getTxMode;



@end