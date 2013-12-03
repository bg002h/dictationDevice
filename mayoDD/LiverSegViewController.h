//
//  LiverSeg3UpperViewController.h
//  mayoDD
//
//  Created by Brian Goss on 11/15/13.
//
//

#import <UIKit/UIKit.h>

@protocol liverSegReportDelegate <NSObject>

-(void) updateLiverReport:(NSString*)s segueName:(NSString *) segueName;

@end

@interface LiverSegViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblLiverSegment;
@property (weak, nonatomic) IBOutlet UIButton *btnCyst;
@property (weak, nonatomic) IBOutlet UITextField *tfCystSize;
@property (weak, nonatomic) IBOutlet UIButton *btnSimpleCyst;
@property (weak, nonatomic) IBOutlet UIButton *btnComplexCyst;
@property (weak, nonatomic) IBOutlet UIButton *btnHemangioma;
@property (weak, nonatomic) IBOutlet UITextField *tfHemangiomaSize;
@property (weak, nonatomic) IBOutlet UIButton *btnProbableHemangioma;
@property (weak, nonatomic) IBOutlet UIButton *btnAtypicalHemangioma;
@property (weak, nonatomic) IBOutlet UIButton *btnMass;
@property (weak, nonatomic) IBOutlet UITextField *tfMassSize;
@property (weak, nonatomic) IBOutlet UIButton *btnHypoechoicMass;
@property (weak, nonatomic) IBOutlet UIButton *btnHyperechoicMass;
@property (weak, nonatomic) IBOutlet UIButton *btnHypoRimMass;
@property (weak, nonatomic) IBOutlet UIButton *btnHeterogeneousMass;
@property (weak, nonatomic) IBOutlet UIButton *btnMetastasisMass;
@property (weak, nonatomic) IBOutlet UIButton *btnProbableMetastasisMass;
@property (weak, nonatomic) IBOutlet UIButton *btnPossibleMetastasisMass;
@property (weak, nonatomic) IBOutlet UIButton *btnKnownMetastasisMass;

@property (strong, nonatomic) NSArray* buttons;
@property (strong, nonatomic) NSArray* textFields;
@property (nonatomic,strong) NSString* segueName;
@property (nonatomic, strong) NSMutableString* ButtonStates;
@property (assign)id <liverSegReportDelegate> delegate;

- (IBAction)btnPressed:(UIButton *)sender;
- (IBAction)tfSizeChanged:(UITextField *)sender;

- (IBAction)dismissKeyboard:(UIControl *)sender;
@end
