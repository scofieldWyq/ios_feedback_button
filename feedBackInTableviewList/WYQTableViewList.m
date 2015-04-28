//
//  WYQTableViewList.m
//  feedBackInTableviewList
//
//  Created by 吴英强 on 15/4/28.
//  Copyright (c) 2015年 吴英强. All rights reserved.
//

#import "WYQTableViewList.h"

#define FEEDBACK_BUTTON_WIDTH  30
#define FEEDBACK_BUTTON_HEIGHT 40

@interface WYQTableViewList() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) CGFloat window_width;
@property (nonatomic) CGFloat window_height;


@property (nonatomic, strong) UIButton *feedBackButton;
@property (nonatomic, strong) UITableView *myTable;

@end
@implementation WYQTableViewList

- (instancetype)init{
    self = [super init];
    
    if(self){
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* prepare some properties */
    [self prepare];
    
    /* set the view layout
     *
     */
    
    /* set the table view */
    self.myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.window_width, self.window_height) style:UITableViewStylePlain];
    [self.myTable setDelegate:self];
    [self.myTable setDataSource:self];
    
    /* set the button of feedback 
     * you can resize the feedback button by set the size of button.
     */
    self.feedBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, FEEDBACK_BUTTON_WIDTH, FEEDBACK_BUTTON_HEIGHT)];
    [self.feedBackButton setBackgroundImage:[UIImage imageNamed:@"fab"] forState:UIControlStateNormal];
    [self.feedBackButton addTarget:self action:@selector(actionForFeedBack:) forControlEvents:UIControlEventTouchUpInside];
    
    /* move it into properate position */
    self.feedBackButton.center = CGPointMake(self.myTable.frame.size.width - FEEDBACK_BUTTON_WIDTH - 10, self.myTable.frame.size.height - FEEDBACK_BUTTON_HEIGHT/2 );
    
    /* add table view into view */
    [self.view addSubview:self.myTable];
    /* add button into table view and hide it */
    [self.view addSubview:self.feedBackButton];
    [self.feedBackButton setHidden:YES];
    
    /*
     * set the data for usely.
     */
    
    /* for reuse */
    [self.myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableviewCell"];
    
}

- (void)actionForFeedBack:(UIButton *)sender
/*
 * this action is for doing something when tag the feedback button.
 */
{
   //doing something here.
}


- (void)prepare
/*
 * prepare for all the basic data or data which is not connection whith view.
 */
{
    
    self.window_height = self.view.frame.size.height - 20;
    self.window_width = self.view.frame.size.width;
    
    /* check the data source is not nil */
    if( ! self.myDataSource )
        @throw [NSException exceptionWithName:@"data source "
                                       reason:@"self.myDataSource is nil, you should use [self setMyDataSource:<NSArray| NSMutableArray>]"
                                     userInfo:nil];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    /* return the number of rows */
    return [self.myDataSource count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableview cell"];
    
    /* if cell is nil allocating for it */
    if(!cell){
        
        cell = [[UITableViewCell alloc] init];
        //
    }
    
    // Configure the cell by using your data...
    cell.textLabel.text = [self.myDataSource objectAtIndex:[indexPath row]];
    
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint off_set = self.myTable.contentOffset;
    
    if( off_set.y > 50 ){
        if( [self.feedBackButton alpha] == 0 ){
            
            [self.feedBackButton setHidden:NO];
            
            [UIView animateWithDuration:0.5
                             animations:^{
                                 [self.feedBackButton setAlpha:1];
                                 
                             } completion:^(BOOL finished) {
                                 // do something ...
                             }];
        }
        
    }
    else {
        [UIView animateWithDuration:0.5 animations:^{
            [self.feedBackButton setAlpha:0];
            
        } completion:^(BOOL finished) {
            // do something ...
        }];
        
    }
}

@end
