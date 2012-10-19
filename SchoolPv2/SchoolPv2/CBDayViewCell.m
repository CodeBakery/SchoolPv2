//
//  CBDayViewCell.m
//  Scheduler
//
//  Created by Christoffer Nordin on 10/12/12.
//
//

#import "CBDayViewCell.h"

@implementation CBDayViewCell

@synthesize courseLabel;
@synthesize teacherLabel;
@synthesize roomLabel;
@synthesize startLabel;
@synthesize stopLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    [[cell detailTextLabel] setBackgroundColor:[UIColor clearColor]];
}

@end
