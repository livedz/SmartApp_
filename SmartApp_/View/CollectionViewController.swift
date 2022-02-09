//
//  CollectionViewController.swift
//  SmartApp_
//
//  Created by MOKSHA on 06/02/22.
//

import UIKit


class CollectionViewController: UIViewController{
  
    
  
       
    @IBOutlet weak var Searchview: UISearchBar!
    @IBOutlet weak var Collectionview: UICollectionView!
    var Viewmodel: Now_playingViewmodel!
    var Now_playingMoviearray = [MovieResults]()
    var Searchlist = [MovieResults]()
   
  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor(named: "Color")
        self.Viewmodel = Now_playingViewmodel()
        self.Viewmodel.moviedelegate = self
     
        
        self.Collectionview.delegate = self
        self.Collectionview.dataSource = self
        self.Collectionview.register(UINib.init(nibName: "popular_moviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "popular_moviesCollectionViewCell")
        self.Collectionview.register(UINib.init(nibName: "unpopular_moviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "unpopular_moviesCollectionViewCell")
          
        self.Viewmodel.GetMovielist()
        self.Searchview.delegate = self
        
        
    }
    
    func UpdatedMovielist(Mlist: [MovieResults]) {
        self.Now_playingMoviearray = Mlist
        self.Searchlist = Mlist
        self.Collectionview.reloadData()
    }
    
    
}

extension CollectionViewController : UICollectionViewDelegate,UICollectionViewDataSource, MovieDelegate ,UICollectionViewDelegateFlowLayout {
    
      
     func numberOfSections(in collectionView: UICollectionView) -> Int {
          1
       }
       
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          
           return self.Searchlist.count
       }
       
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           let movie = self.Searchlist[indexPath.row] as MovieResults
           
           if movie.vote_average! >= 7.0
           {
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popular_moviesCollectionViewCell", for: indexPath) as! popular_moviesCollectionViewCell
               cell.Posterimgview.layer.masksToBounds = true
               cell.Posterimgview.layer.cornerRadius = 10
               cell.Posterimgview.loadRemoteImageFrom(urlString:self.Viewmodel.backdropbaseUrl + movie.backdrop_path!)
            return cell
                  
           } else {
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unpopular_moviesCollectionViewCell", for: indexPath) as! unpopular_moviesCollectionViewCell
               cell.Posterimgview.layer.masksToBounds = true
               cell.Posterimgview.layer.cornerRadius = 10
               cell.Posterimgview.loadRemoteImageFrom(urlString: self.Viewmodel.MoviePosterbaseUrl + movie.poster_path!)
               cell.Movietitlelbl.text = movie.title
               cell.Overviewlbl.text = movie.overview
           return cell
              
           }
       }
    
    @objc func rightSwipe() {
           print(">> right swipe")
       }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width, height: 235)
        
    }
   
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.urlstring = self.Viewmodel.MoviePosterbaseUrl + self.Searchlist[indexPath.row].poster_path!
        self.present(vc, animated: true, completion: nil)
        
    }
  
     func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
         collectionView.performBatchUpdates({
             collectionView.deleteItems(at: [IndexPath(item: indexPath.row, section: 0)])
         }, completion: nil)
         self.Searchlist.remove(at: indexPath.row)
         self.Now_playingMoviearray.remove(at: indexPath.row)
      }

 
}


extension CollectionViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
        self.Searchlist.removeAll()
        Searchlist = searchText.isEmpty ? self.Now_playingMoviearray : self.Now_playingMoviearray.filter { $0.original_title!.lowercased().contains(searchText.lowercased()) || $0.title!.lowercased().contains(searchText.lowercased())  }

        self.Collectionview.reloadData()
    }
    
 
}

let imageCache = NSCache<AnyObject, AnyObject>()
let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)


extension UIImageView {
  func loadRemoteImageFrom(urlString: String){
    let url = URL(string: urlString)
    image = nil
    activityView.center = self.center
    self.addSubview(activityView)
    activityView.startAnimating()
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
        self.image = imageFromCache
        activityView.stopAnimating()
        activityView.removeFromSuperview()
        return
    }
    URLSession.shared.dataTask(with: url!) {
        data, response, error in
        DispatchQueue.main.async {
            activityView.stopAnimating()
            activityView.removeFromSuperview()
        }
          if let response = data {
              DispatchQueue.main.async {
                if let imageToCache = UIImage(data: response) {
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }else{
                    self.loadRemoteImageFrom(urlString: "https://images.assetsdelivery.com/compings_v2/yehorlisnyi/yehorlisnyi2104/yehorlisnyi210400016.jpg")
                }
              }
          }
     }.resume()
  }
}
