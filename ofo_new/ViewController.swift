//
//  ViewController.swift
//  ofo_new
//
//  Created by idea on 2017/7/24.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit
import SWRevealViewController

class ViewController: UIViewController,MAMapViewDelegate ,AMapSearchDelegate{
    
    var mapView:MAMapView!
    var search :AMapSearchAPI!

    @IBAction func 定位(_ sender: UIButton) {
        searchBirkNearby()
    }
 
    @IBOutlet weak var pView: UIView!
    
    
    func searchBirkNearby() {
        searchCustomlocation(mapView.userLocation.coordinate)
    }
    
    func searchCustomlocation(_ center: CLLocationCoordinate2D) {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(center.latitude), longitude: CGFloat(center.longitude))
        
        request.keywords = "餐馆"
        request.radius = 500
        request.requireExtension = true
        
        search.aMapPOIAroundSearch(request)
    }
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
      
        guard response.count > 0 else {
            print("周围没有小黄车")
            return
        }
        var annotations : [MAPointAnnotation] = []
        annotations = response.pois.map{
            let annotation = MAPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.location.latitude), longitude: CLLocationDegrees($0.location.longitude))
            
            if $0.distance < 200{
                annotation.title = "红包区域内开锁任意小黄车"
                annotation.subtitle = "骑行10分钟可以获得现金红包"
            }else{
                annotation.title = "正常可用"
            }
            
            return annotation
        }
        mapView.addAnnotations(annotations)
        
//        将地图按照搜索进行缩放，实现现实所有搜索结果
        mapView.showAnnotations(annotations, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//         导入高德地图
        mapView = MAMapView(frame: view.bounds)
        view.addSubview(mapView)
        view.bringSubview(toFront: pView)
        
        
        mapView.delegate = self
        
//        缩放
        mapView.zoomLevel = 17
//        定位
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        search = AMapSearchAPI()
        search.delegate = self


        
        // Do any additional setup after loading the view, typically from a nib.
        view.bringSubview(toFront:pView)
        
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "ofoLogo"))
        
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "leftTopImage").withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "rightTopImage").withRenderingMode(.alwaysOriginal)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        if let revealVC = revealViewController(){
            
//             宽度
            revealVC.rearViewRevealWidth = 280
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

