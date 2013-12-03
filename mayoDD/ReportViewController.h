//
//  ReportViewController.h
//  mayoDD
//
//  Created by Brian Goss on 11/15/13.
//
//

#import <UIKit/UIKit.h>
#import "myRscMgr.h"
#import "TPKeyboardAvoidingScrollView.h"


@interface ReportViewController : UIViewController<UITextViewDelegate, UITextFieldDelegate, RscMgrDelegate>{
    myRscMgr *rscMgr;
}

@property (weak, nonatomic) IBOutlet UITextView *tvReport;
@property (weak, nonatomic) IBOutlet UILabel *lblReport;
@property (weak, nonatomic) IBOutlet UINavigationItem *navTopBar;

@property (nonatomic,strong) NSString* reportString;

- (IBAction)sendString:(id)sender;


@end
