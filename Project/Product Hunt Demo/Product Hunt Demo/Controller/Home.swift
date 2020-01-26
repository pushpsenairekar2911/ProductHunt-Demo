//
//  Products.swift
//  Product Hunt Demo
//
//  Created by pushpsen airekar on 25/01/20.
//  Copyright © 2020 pushpsen airekar. All rights reserved.
//

// MARK: - Importing Frameworks.

import UIKit

/* -------------------------------------------------------------------------------------- */

class Home: UIViewController {
    
    // MARK: - Declaration of Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var daysSegmentControl: UISegmentedControl!
    
    
    // MARK: - Declaration of Variables
    var posts: [Post] = [Post]()
    var filteredPosts: [Post] = [Post]()
    var activityIndicator:UIActivityIndicatorView?
    var searchController:UISearchController = UISearchController(searchResultsController: nil)
    
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupSearchBar()
        self.fetchPosts(for: .today)
    }
    
    
    // MARK: - Private Instance Methods
    
    /**
     This method feches the posts for given day
     - Parameter day: This specifies a day.
    - Author: Pushpsen Airekar
    - Copyright: Copyright © 2020 Pushpsen Airekar
    */
    private func fetchPosts(for day: Day){
        activityIndicator?.startAnimating()
        activityIndicator?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = activityIndicator
        tableView.tableFooterView = activityIndicator
        tableView.tableFooterView?.isHidden = false
        ProductHuntManager().fetchPosts(for: day) { (posts, error) in
            if let posts = posts {
                print("posts :\(posts)")
                self.posts = posts
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating()
                    self.tableView.tableFooterView?.isHidden = true
                    self.tableView.reloadData()
                }
            }
            if let error = error {
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating()
                    self.tableView.tableFooterView?.isHidden = true
                    self.tableView.reloadData()
                }
                print("error :\(error.localizedDescription)")
            }
        }
    }
    
    /**
     This method setup the search bar for home screen.
    - Author: Pushpsen Airekar
    - Copyright: Copyright © 2020 Pushpsen Airekar
    */
    private func setupSearchBar(){
        // SearchBar Apperance
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        if #available(iOS 13.0, *) {
            searchController.searchBar.barTintColor = .systemBackground
        } else {}
        if #available(iOS 11.0, *) {
            if navigationController != nil{
                navigationItem.searchController = searchController
            }else{
                if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
                    if #available(iOS 13.0, *) {textfield.textColor = .label } else {}
                    if let backgroundview = textfield.subviews.first{
                        backgroundview.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
                        backgroundview.layer.cornerRadius = 10
                        backgroundview.clipsToBounds = true
                    }}
                tableView.tableHeaderView = searchController.searchBar
            }} else {}
        searchController.searchBar.scopeButtonTitles = ["Today", "Yesterday", "2 days ago", "3 days ago"]
        searchController.searchBar.showsScopeBar = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    /**
     This method setup the table view for home screen.
    - Author: Pushpsen Airekar
    - Copyright: Copyright © 2020 Pushpsen Airekar
    */
    private func setupTableView(){
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator?.color = #colorLiteral(red: 1, green: 0.2820675373, blue: 0.01443537045, alpha: 1)
        } else {}
        let ProductCell  = UINib.init(nibName: "ProductCell", bundle: nil)
        self.tableView.register(ProductCell, forCellReuseIdentifier: "productCell")
    }
    
    /**
     This method notifies when the search bar is empty.
    - Author: Pushpsen Airekar
    - Copyright: Copyright © 2020 Pushpsen Airekar
    */
       private func searchBarIsEmpty() -> Bool {
           return searchController.searchBar.text?.isEmpty ?? true
       }
       
    /**
     This method notifies when the search bar is in seach mode.
    - Author: Pushpsen Airekar
    - Copyright: Copyright © 2020 Pushpsen Airekar
    */
       private func isSearching() -> Bool {
           let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
           return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
       }
    
}



/* -------------------------------------------------------------------------------------- */

// MARK: - UISearchBar Delegate

extension Home : UISearchBarDelegate, UISearchResultsUpdating {
    
    /**
     This method update results when the search bar is in seach mode.
      - Parameter searchController: A view controller that manages the display of search results based on interactions with a search bar.
    - Author: Pushpsen Airekar
    - Copyright: Copyright © 2020 Pushpsen Airekar
    */
    func updateSearchResults(for searchController: UISearchController) {
        
        if let text = searchController.searchBar.text {
            filteredPosts = posts.filter { (post: Post) -> Bool in
                
                return (post.title.lowercased().contains(text.lowercased()) || post.message.lowercased().contains(text.lowercased()))
                
            }
            self.tableView.reloadData()
        }
    }
    
    /**
     This method triggers when user taps on segment control on home screen.
     - Parameters:
       - searchBar: A view controller that manages the display of search results based on interactions with a search bar.
      - selectedScope: This specifies an `Int` value.
    - Author: Pushpsen Airekar
    - Copyright: Copyright © 2020 Pushpsen Airekar
    */
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        switch selectedScope {
        case 0: self.fetchPosts(for: .today)
        case 1: self.fetchPosts(for: .yesterday)
        case 2: self.fetchPosts(for: .twoDaysAgo)
        case 3: self.fetchPosts(for: .threeDaysAgo)
        default:break
        }
    }
}

/* -------------------------------------------------------------------------------------- */

// MARK: - TableView Instance  Methods

extension Home : UITableViewDelegate, UITableViewDataSource {
    
    /// This method specifies the number of sections to display list of posts.
    /// - Parameter tableView: An object representing the table view requesting this information.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// This method specifies number of rows in Home screen
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching(){
            return filteredPosts.count
        }else{
            return posts.count
        }
    }
    
    /// This method specifies the view for post  in Home screen
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let productCell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductCell
        let post: Post?
        if isSearching() {
            post = filteredPosts[indexPath.row]
        } else {
            post = posts[indexPath.row]
        }
        productCell.post = post
        return productCell
    }
    
    /// This method specifies the height for row in Home screen
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    /// This method triggers when particular cell is clicked by the user .
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - indexPath: specifies current index for TableViewCell.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selectedPost = tableView.cellForRow(at: indexPath) as? ProductCell {
            
            guard let comments = storyboard?.instantiateViewController(withIdentifier: "comments") as? Comments else { return }
            comments.currentPid = selectedPost.post.pid
            comments.title = selectedPost.post.title
            self.navigationController?.pushViewController(comments, animated: true)
        }
    }
}

/* -------------------------------------------------------------------------------------- */
