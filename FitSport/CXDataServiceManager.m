//
//  CXDataServiceManager.m
//  FitSport
//
//  Created by Manishi on 11/4/16.
//  Copyright © 2016 ongo. All rights reserved.
//

#import "CXDataServiceManager.h"

@implementation CXDataServiceManager


+ (id)sharedManager
{
    static id sharedManager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


#pragma mark GetMaster Api 

- (void)getTheAppDataFromServer:(NSDictionary*)parameters {
    
    
    
    NSURL *baseURL = [NSURL URLWithString:@""];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    

    [manager GET:@"weather.php" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
    }];
}

/*
 
 open func getTheAppDataFromServer(_ parameters:[String: AnyObject]? = nil ,completion:@escaping (_ responseDict:NSDictionary) -> Void){
 //        if Bool(1) {
 //            print(CXAppConfig.sharedInstance.getBaseUrl() + CXAppConfig.sharedInstance.getMasterUrl())
 //            print(parameters)
 //
 //        Alamofire.request(.GET,CXAppConfig.sharedInstance.getBaseUrl() + CXAppConfig.sharedInstance.getMasterUrl() , parameters: parameters)
 //            .validate()
 //            .responseJSON { response in
 //                switch response.result {
 //                case .success:
 //                   // print("Validation Successful\(response.result.value)")
 //                    completion(responseDict: (response.result.value as? NSDictionary)!)
 //                    break
 //                case .failure(let error):
 //                    print(error)
 //                }
 //        }
 //        }else{
 //
 //        }
 //
 //    }

 */


@end


/*
 
 interests=Subroom1(119432)#Subroom6(119438)........
 1.Retrieve users based on tags(Interests)
 http://localhost:8081/MobileAPIs/getTagBasedUsers?mallId=530&tagArr=Subroom1(119432)#Subroom6(119438)
 2.Retrieve users which a single user is following.
 User follow
 http://localhost:8081/Services/createORGetJobInstance?email=cxsample@gmail.com&orgId=530&activityName=User_Follow&loyalty=true&ItemCodes=ca66007a-fd50-479f-9c8f-06a5323d4154&trackOnlyOnce=true
 
 itemcodes = User itemcodes(MacId)
 Retrieve all users following by singel user
 http://localhost:8081/MobileAPIs/getJobsFollowingBy?email=cxsample@gmail.com&mallId=530&type=User_Follow
 3.Retrieve users who are already being followed and attending the event
 Event_Follow
 http://localhost:8081/Services/createORGetJobInstance?email=cxsample@gmail.com&orgId=530&activityName=Event_Follow&loyalty=true&ItemCodes=ca66007a-fd50-479f-9c8f-06a5323d4154&trackOnlyOnce=true
 itemcodes = Event itemcode
 
 Retrieve all users following event
 http://localhost:8081/MobileAPIs/getJobsFollowing?mallId=530&type=Event_Follow&itemCode=070616-FAGDFHDH
 itemcode = Event itemcode
 Retrieve users who are already being followed logged in user and attending the event which user is viewing
 http://localhost:8081/MobileAPIs/getJobsFollowing?email=cxsample@gmail.com&mallId=530&type=Event_Follow&itemCode=Rooms2
 itemcode = Event itemcode
 4.User wise events---- for getting
 Retrieve all events following by singel user
 http://localhost:8081/MobileAPIs/getJobsFollowingBy?email=cxsample@gmail.com&mallId=530&type=Event_Follow
 Already attended events
 Registered events
 5.API for creating event.
 
 UNFOLLOW
 http://localhost:8081/Services/deleteJobInstanceOrActivity?email=cxsample@gmail.com&orgId=530&activityName=User_Follow&ItemCode=ca66007a-fd50-479f-9c8f-06a5323d4154
 
 Feeds API : http://localhost:8081/MobileAPIs/getFeeds?email=cxsample4@gmail.com&ownerId=530
 
 
 */
