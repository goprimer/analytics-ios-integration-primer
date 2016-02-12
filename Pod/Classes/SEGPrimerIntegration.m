
#import "SEGPrimerIntegration.h"

#import <Analytics/SEGAnalytics.h>
#import <Analytics/SEGAnalyticsUtils.h>
#import <Primer/Primer.h>

@implementation SEGPrimerIntegration

- (id)initWithSettings:(NSDictionary *)settings
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _settings = settings;
    
    SEGLog(@"Enabling Primer Event Notification");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivePrimerEventNotification:)
                                                 name:PrimerEventFiredNotification
                                               object:nil];
    
    return self;
}

- (void)track:(SEGTrackPayload *)payload
{
    NSMutableDictionary *segmentProperties = [NSMutableDictionary dictionary];
    segmentProperties[@"segment_context"] = payload.context ?: @{};
    segmentProperties[@"segment_integrations"] = payload.integrations ?: @{};
    
    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithDictionary:payload.properties];
    properties[@"integration_source"] = @"segment-ios";
    properties[@"segment_properties"] = segmentProperties;
    
    SEGLog(@"[[Primer sharedInstance] track:%@ properties:%@]", payload.event, properties);
    [[Primer sharedInstance] track:payload.event properties:properties];
}

- (void)identify:(SEGIdentifyPayload *)payload
{
    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithDictionary:payload.traits];
    properties[@"segment_anonymous_id"] = payload.anonymousId ?: @"";
    properties[@"segment_user_id"] = payload.userId ?: @"";
    
    SEGLog(@"[[Primer sharedInstance] appendUserProperties:%@]", properties);
    [[Primer sharedInstance] appendUserProperties:properties];
}

- (void)receivePrimerEventNotification:(NSNotification *)notification
{
    if (![notification.name isEqualToString:PrimerEventFiredNotification]) {
        return;
    }
    
    NSString *eventName = notification.userInfo[PrimerEventNotificationNameKey];
    NSMutableDictionary *properties = [NSMutableDictionary dictionaryWithDictionary:notification.userInfo[PrimerEventNotificationPropertiesKey]];
    properties[@"integration_source"] = @"segment-ios";
    
    [[SEGAnalytics sharedAnalytics] track:eventName properties:properties];
}

@end
