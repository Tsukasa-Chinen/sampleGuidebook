//
//  ViewController.swift
//  sampleGuidebook
//
//  Created by Tsukasa Chinen on 2017/11/10.
//  Copyright © 2017年 Tsukasa Chinen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    var selectedName = ""
    var areaList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.delegate = self
        myTableView.dataSource = self

        /* ファイルパス取得（エリア名が格納されているプロパティリスト） */
        let filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
        
        /* ファイルの内容を読み込んでディクショナリ型に格納 */
        let dic = NSDictionary(contentsOfFile: filePath!)

        /* TableViewで扱いやすい配列の形を作成（エリア名の入ってる配列） */
        for (key, data) in dic! {
            areaList.append(key as! String)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }

    /* 3. リストに表示する文字列を決定し表示 */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* 文字を表示するセルの取得 */
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        /* 表示したい文字の設定 （行数の設定で指定した数だけループされる）*/
        cell.textLabel?.text = areaList[indexPath.row]

        /* 文字を設定したセルを返す */
        return cell
    }

    /* セルがタップされた時 */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* タップされた行のエリア名 */
        selectedName = areaList[indexPath.row]

        /* セグエのidentifierを指定して、画面移動 */
        performSegue(withIdentifier: "showDetail", sender: nil)
        
    }
    
    /* セグエをつかって画面移動するとき発動 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* 次の画面のインスタンスを取得 */
        let dvc = segue.destination as! DetailViewController
        
        /* 次の画面のプロパティにタップされた行のエリア名を渡す */
        dvc.getAreaName = selectedName

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

