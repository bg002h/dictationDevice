//
//  SecondViewController.h
//  mayoDD
//
//  Created by Brian Goss on 10/28/13.
//
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "myRscMgr.h"


#define BUFFER_LEN 4096


@interface SecondViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate, RscMgrDelegate>{
    myRscMgr *rscMgr;
    UInt8 rxBuffer[BUFFER_LEN];
    UInt8 txBuffer[BUFFER_LEN];
    
    int begins;
    int chunkSize;
    int ends;


}
@property (retain, nonatomic) IBOutlet UISegmentedControl *scCFVR;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scPFVR;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scFVR;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scPOPR;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scPTVR;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scPERR;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scCystR;

@property (retain, nonatomic) IBOutlet UISegmentedControl *scCFVL;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scPFVL;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scFVL;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scPOPL;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scPTVL;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scPERL;
@property (retain, nonatomic) IBOutlet UISegmentedControl *scCystL;


//third view controller
//@property (weak, nonatomic) IBOutlet UIButton *bPatentR;
//@property (weak, nonatomic) IBOutlet UIButton *bPatentL;
//@property (weak, nonatomic) IBOutlet UIButton *bCephR;
//@property (weak, nonatomic) IBOutlet UIButton *bCephL;
//
//@property BOOL* selectedBool;
//
//@property (weak, nonatomic) IBOutlet UITextField *tfCCAR;
//@property (weak, nonatomic) IBOutlet UITextField *tfICAPSVR;
//@property (weak, nonatomic) IBOutlet UITextField *tfICAEDVR;
//@property (weak, nonatomic) IBOutlet UITextField *tfECAR;
//@property (weak, nonatomic) IBOutlet UITextField *tfICARatioR;
//
//@property (weak, nonatomic) IBOutlet UITextField *tfCCAL;
//@property (weak, nonatomic) IBOutlet UITextField *tfICAPSVL;
//@property (weak, nonatomic) IBOutlet UITextField *tfICAEDVL;
//@property (weak, nonatomic) IBOutlet UITextField *tfECAL;
//@property (weak, nonatomic) IBOutlet UITextField *tfICARatioL;

//end thirdview controller




@property (weak, nonatomic) IBOutlet UITextView *reportView;
@property (retain, nonatomic) NSString *strTypeThis;

- (IBAction) updateReport:sender;
- (IBAction) typeReport:(id) sender;

@end
