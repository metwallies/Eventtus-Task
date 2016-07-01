//
//  CachingManager.m
//  SmarTech task
//
//  Created by islam metwally on 3/31/16.
//  Copyright © 2016 Islam Metwally. All rights reserved.
//

#import "AppDelegate.h"
#import "CachingManager.h"
#import "Follower.h"

@implementation CachingManager

+(id) sharedInstance {
    
    static CachingManager *sharedInstance;
    if (sharedInstance == nil) {
        sharedInstance = [[CachingManager alloc] init];
    }
    return sharedInstance;
}

-(void) saveFollower:(Follower *)follower {
    
    NSManagedObjectContext *context = [APPLICATION_DELEGATE managedObjectContext];
    
    NSManagedObject *followerContext = [NSEntityDescription insertNewObjectForEntityForName:@"Follower" inManagedObjectContext:context];
    
    [followerContext setValue:follower.followerID forKey:@"followerID"];
    [followerContext setValue:follower.followerName forKey:@"followerName"];
    [followerContext setValue:follower.followerScreenName forKey:@"followerScreenName"];
    [followerContext setValue:follower.image forKey:@"followerImage"];
    if (![follower.BGImage isKindOfClass:[NSNull class]])
        [followerContext setValue:follower.BGImage forKey:@"followerBGImage"];
    [followerContext setValue:follower.followerDescription forKey:@"followerDesc"];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"couldn't save: %@", [error localizedDescription]);
    }
}

-(NSArray *) fetchFollowersFromCache {
    
    NSManagedObjectContext *context = [APPLICATION_DELEGATE managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Follower"
                                   inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSError *error;
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        
        NSArray *keys = [[[info entity] attributesByName] allKeys];
        NSDictionary *dict = [info dictionaryWithValuesForKeys:keys];
        
        Follower *follower = [[Follower alloc] initWithDictionary:dict];
        [results addObject:follower];
    }
    if (results.count) {
        return (NSArray *)results;
    }
    return nil;
}

-(void) DeleteFollowersFromCache {
    
    NSManagedObjectContext *context = [APPLICATION_DELEGATE managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Follower"
                                   inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:nil];
    for (NSManagedObject *object in fetchedObjects) {
        
        [context deleteObject:object];
    }
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
}

@end
