
#import "SEGPrimerIntegrationFactory.h"

#import <Primer/Primer.h>

#import "SEGPrimerIntegration.h"

@implementation SEGPrimerIntegrationFactory

+ (instancetype)instanceWithToken:(NSString *)token
{
    static dispatch_once_t once;
    static SEGPrimerIntegrationFactory *sharedInstance;
    dispatch_once(&once, ^{
        [Primer startWithToken:token];
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    return self;
}

- (id<SEGIntegration>)createWithSettings:(NSDictionary *)settings forAnalytics:(SEGAnalytics *)analytics
{
    return [[SEGPrimerIntegration alloc] initWithSettings:settings];
}

- (NSString *)key
{
    return @"Primer";
}

@end
