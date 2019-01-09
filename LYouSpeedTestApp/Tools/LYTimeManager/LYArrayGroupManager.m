//
//  LYArrayGroupManager.m
//  LYouSpeedTestApp
//
//  Created by grx on 2019/1/9.
//  Copyright © 2019 grx. All rights reserved.
//

#import "LYArrayGroupManager.h"

@implementation LYArrayGroupManager

-(NSMutableArray *)gaintArray:(NSArray *)listArray{
    NSMutableArray *array = [NSMutableArray arrayWithArray:listArray];
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    for (int i = 0; i < array.count; i ++) {
        NSString *string = array[i];
        NSMutableArray *tempArray = [@[] mutableCopy];
        [tempArray addObject:string];
        for (int j = i+1; j < array.count; j ++) {
            NSString *jstring = array[j];
            if([string isEqualToString:jstring]){
                [tempArray addObject:jstring];
                [array removeObjectAtIndex:j];
                j -= 1;
            }
        }
        [dateMutablearray addObject:tempArray];
    }
    return dateMutablearray;
}

@end
