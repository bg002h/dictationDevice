//
//  LiverViewController.h
//  mayoDD
//
//  Created by Brian Goss on 11/15/13.
//
//

#import <UIKit/UIKit.h>
#import "LiverSegViewController.h"

@protocol abdReportDelegate <NSObject>
-(void) updateAbdReport:(NSString*)s segueName:(NSString *) segueName;
@end

@interface LiverViewController : UIViewController<liverSegReportDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblSeg1Lower;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg1Mid;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg1Upper;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg3Lower;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg3Upper;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg4BLower;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg4BUpper;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg5Lower;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg5Upper;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg6Upper;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg6Lower;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg2Lower;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg2Upper;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg4ALower;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg4AUpper;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg8Lower;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg8Upper;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg7Lower;
@property (weak, nonatomic) IBOutlet UILabel *lblSeg7Upper;
@property (weak, nonatomic) IBOutlet UIButton *btnFatty;
@property (weak, nonatomic) IBOutlet UIButton *btnCoarse;
@property (weak, nonatomic) IBOutlet UIButton *btnCirrhoticM;
@property (weak, nonatomic) IBOutlet UIButton *btnNodularC;


@property (strong, nonatomic) NSMutableString* liverReport;
@property (strong, nonatomic) NSMutableDictionary* liverSegButtonStates;
-(void) updateLiverReport:(NSString *)s segueName:(NSString *)segueName;
-(IBAction)updateLiverReport:(UIButton*)sender;//for fatty, coarse, etc
- (NSMutableDictionary*) getliverSegButtonStates;
@end
