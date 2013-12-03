//
//  myRscMgr.h
//  mayoDD
//
//  Created by Brian Goss on 11/12/13.
//
//

#import <Foundation/Foundation.h>
#import "RscMgr.h"

#define BUFFER_LEN 4096

@interface myRscMgr : RscMgr <RscMgrDelegate>{
    myRscMgr *rscMgr;
    UInt8 rxBuffer[BUFFER_LEN];
    UInt8 txBuffer[BUFFER_LEN];
    
    int begin;
    int chunkSize;
    int end;
}


- (void) sendString: (NSString* )s;

- (void) cableConnected:(NSString *)protocol;
- (void) cableDisconnected;
- (void) portStatusChanged;
- (void) readBytesAvailable:(UInt32)numBytes;
- (void) didReceivePortConfig;
- (void)setTxMode:(BOOL)on;
+ (id)sharedInstance;






@end
