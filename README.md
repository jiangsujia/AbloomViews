# AbloomViews -- 仿开眼点击效果

应用于列表图片飞去下一个ViewController ， 以及消失动画

![image](https://github.com/jiangsujia/AbloomViews/blob/master/show.gif)


AbloomTableViewController 中 目前创建需要两步，在触发列表点击事件的时候 ：

    //如果不是列表，而是普通的ImageView 可以将其值直接赋值给self.showAbloomView

    [self transitionViewByTableView:tableView indexPath:indexPath];

    //这一步是必要的，但是如果要出动画效果 一定要把需要飞出的imageView赋值给self.showAbloomView 就是上一步

    [self presentAbloomViewController:dimissVC animated:YES completion:nil];

    //dimissVC对应AbloomDismissViewController
    

AbloomDismissViewController 中 消失动画是：
   
     [self dimissAbloomViewControllerAnimated:YES completion:nil];

 
  但是前提是创建self.showAbloomView 在未进行viewDidLoad的时候 就要给self.showAbloomView进行frame 和 image的赋值
  
    
