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

class Comments: UIViewController {
    
    // MARK: - Declaration of Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Declaration of Variables
    
    var currentPid: String?
    var activityIndicator:UIActivityIndicatorView?
    var comments: [Comment] = [Comment]()
    
    
    // MARK: - View controller lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.fetchComments()
        
    }
    
    
    // MARK: - Private Instance Methods
    private func setupTableView(){
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator?.color = #colorLiteral(red: 1, green: 0.2820675373, blue: 0.01443537045, alpha: 1)
        } else {}
        let CommentCell  = UINib.init(nibName: "CommentCell", bundle: nil)
        self.tableView.register(CommentCell, forCellReuseIdentifier: "commentCell")
    }
    
    
    /**
     This method feches the comments for  perticular post
     - Parameter day: This specifies a day.
     - Author: Pushpsen Airekar
     - Copyright: Copyright © 2020 Pushpsen Airekar
     */
    private func fetchComments(){
        
        guard let pid = currentPid else { return }
        activityIndicator?.startAnimating()
        activityIndicator?.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = activityIndicator
        tableView.tableFooterView = activityIndicator
        tableView.tableFooterView?.isHidden = false
        ProductHuntManager().fetchComments(forPost: pid) { (comments, error) in
            if let comments = comments {
                self.comments = comments
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
                print("error is: \(error.localizedDescription)")
            }
        }
    }
}

/* -------------------------------------------------------------------------------------- */

// MARK: - TableView Instance  Methods

extension Comments : UITableViewDelegate, UITableViewDataSource {
    
    /// This method specifies the number of sections to display list of comments.
    /// - Parameter tableView: An object representing the table view requesting this information.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// This method specifiesnumber of rows in Comments
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    /// This method specifies the view for comment  in Comments
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let commentCell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell
        let comment = comments[indexPath.row]
        commentCell.comment = comment
        return commentCell
    }
    
    /// This method specifies the height for row in Comments
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - section: An index number identifying a section of tableView .
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
}

/* -------------------------------------------------------------------------------------- */
