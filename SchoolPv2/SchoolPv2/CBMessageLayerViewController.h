#import <UIKit/UIKit.h>

@interface CBMessageLayerViewController : UIViewController

@property (nonatomic, weak) id delegate;
@property (weak, nonatomic) IBOutlet UITableView *messageTable;

- (void)exitAdmin:(id)sender;

@end
