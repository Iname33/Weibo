//
//  MoreViewController.m
//  08.新浪微博
//
//  Created by 伍承标 on 2017/8/30.
//  Copyright © 2017年 伍承标. All rights reserved.
//




#import "MoreViewController.h"

@interface MoreViewController ()
@property(strong,nonatomic)NSArray*data;
@end

@implementation MoreViewController

-(NSArray *)data{
    if (!_data) {
        NSString* path = [[NSBundle mainBundle]pathForResource:@"More" ofType:@"plist"];
        
        _data = [NSArray arrayWithContentsOfFile:path];
    }
    return _data;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildui];
    
//    [self loadplist];
    
    [self buildTableview];
}

-(void)buildTableview{
   
    
    
}

//-(void)loadplist{
//    NSURL*url=[[NSBundle mainBundle] URLForResource:@"More" withExtension:@"plist"];
//    _data=[NSArray arrayWithContentsOfURL:url];
//}

-(void)buildui{
    self.title=@"更多";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"设置" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
    // 1.设置背景
    // backgroundView的优先级 > backgroundColor
    self.tableView.backgroundView = nil;
    //    // 0~1
    self.tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    // 2.设置tableView每组头部的高度
    self.tableView.sectionHeaderHeight = 5;
    self.tableView.sectionFooterHeight = 0;
    


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.data[section] count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString*reuseID=@"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:reuseID];
    }
    NSDictionary*dic=_data[indexPath.section][indexPath.row];
    cell.textLabel.text=dic[@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==2) {
        cell.detailTextLabel.text=indexPath.row?@"经典主题":@"有图模式";
    }
    return cell;
    
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
