//
//  DetailViewController.swift
//  sampleGuidebook
//
//  Created by Tsukasa Chinen on 2017/11/10.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    /* 前の画面から受け取るためのプロパティ */
    var getAreaName = ""
    
    @IBOutlet weak var myDescription: UITextView!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        /* ファイルパス取得（エリア名が格納されているプロパティリスト） */
        let filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
        
        /* ファイルの内容を読み込んでディクショナリ型に格納 */
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        /* 画面タイトルを変更 */
        //navigationItem.title = getAreaName
        self.title = getAreaName

        /* 今画面に表示したいメインデータ */
        let detailInfo = dic![getAreaName] as! NSDictionary
        myDescription.text = detailInfo["description"] as! String
        myImage.image = UIImage(named: detailInfo["image"] as! String)

        let lat = detailInfo["latitude"] as! String
        let lng = detailInfo["longitude"] as! String

        let codinate = CLLocationCoordinate2D(latitude: atof(lat), longitude: atof(lng)) /* 中心となる場所の座標オブジェクトを作成 */
        let span = MKCoordinateSpanMake(0.01, 0.01) /* 縮尺を設定 */
        let region = MKCoordinateRegionMake(codinate, span) /* 範囲オブジェクトを作成 */
        myMap.setRegion(region, animated: true) /* MapViewに範囲オブジェクトを設定 */

        /* Pinを追加 */
        let centerPin = MKPointAnnotation()
        centerPin.coordinate = codinate
        myMap.addAnnotation(centerPin)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
