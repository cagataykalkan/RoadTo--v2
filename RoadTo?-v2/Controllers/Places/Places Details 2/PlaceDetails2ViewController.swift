//
//  PlaceDetails2ViewController.swift
//  RoadTo?-v2
//
//  Created by Çağatay KALKAN on 10.12.2024.
//

import UIKit

class PlaceDetails2ViewController: UIViewController {

    
    @IBOutlet weak var explanationLabel: UILabel!
    var place: PlaceData? // Tıklanan yerin bilgilerini tutacak

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let scrollView = UIScrollView()
        scrollView.frame = view.bounds // Ekran boyutunda bir ScrollView
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000) // İçeriğin boyutu
        view.addSubview(scrollView)

        
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        explanationLabel.text = "djkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkfdjkbfnskjfnkjdsfjkdsfnsdjkfnjdsfnjkdsfnsdnfjkdsnjfksdnjkfdsnjfnsdjkfnjkdsfnjksdfnjsdnjkfdsjknfnjksdfnjkdsndsfjknfjkdsnjkfsnjkdfnjksdfnjkdsfnjsdnjfksdkjnfdnksjfnjksdfnjksdnjkfsdjknfsdnjkf"

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
