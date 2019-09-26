//
//  MovieInfoViewModel.swift
//  HeadyMovies
//
//  Created by Rajdeep Sahoo on 26/09/19.
//  Copyright © 2019 Rajdeep Sahoo. All rights reserved.
//

import UIKit

// MARK: - Local Methods
extension MovieInfoViewController {
    
    func setupViews() {
        navigationBarSetup()
        setupTableView()
    }
    
    func navigationBarSetup() {
        self.navigationController?.navigationBar.tintColor = UIColor(rgb: GREEN_COLOR)
    }
    
    func setupTableView() {
        tableView?.register(UINib(nibName: "MovieTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTitleTableViewCell")
        tableView?.register(UINib(nibName: "MoviePosterTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviePosterTableViewCell")
        tableView?.register(UINib(nibName: "MovieRatingReleaseDateTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieRatingReleaseDateTableViewCell")
        tableView?.register(UINib(nibName: "MovieOverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieOverviewTableViewCell")
    }
    
}


// MARK: - Table View Data Sources
extension MovieInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTitleTableViewCell", for: indexPath) as! MovieTitleTableViewCell
            cell.movieTitleLbl.text = movie.originalTitle
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviePosterTableViewCell", for: indexPath) as! MoviePosterTableViewCell
            if let posterPath = self.movie.posterPath {
                Utility.shared.setImage(from: IMAGE_BASE_URL + posterPath, on: cell.moviePosterImgView)
            } else if let backdropPath = self.movie.backdropPath {
                Utility.shared.setImage(from: IMAGE_BASE_URL + backdropPath, on: cell.moviePosterImgView)
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieRatingReleaseDateTableViewCell", for: indexPath) as! MovieRatingReleaseDateTableViewCell
            
            cell.movieRatingLbl.text = "\(movie.voteAverage)"
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-mm-dd"
            
            let dateFormatterPut = DateFormatter()
            dateFormatterPut.dateFormat = "MMM d, yyyy"
            
            if let date = dateFormatterGet.date(from: movie.releaseDate) {
                cell.movieReleaseDateLbl.text = dateFormatterPut.string(from: date)
            }
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieOverviewTableViewCell", for: indexPath) as! MovieOverviewTableViewCell
            cell.movieOverviewLbl.text = movie.overview
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
