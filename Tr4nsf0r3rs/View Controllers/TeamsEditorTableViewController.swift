 //
//  TeamsEditorTableViewController.swift
//  Tr4nsf0r3rs
//
//  Created by Daniel Bolivar herrera on 16/04/2018.
//  Copyright © 2018 Daniel Bolivar herrera. All rights reserved.
//

import UIKit
import RMessage

private let teamHeaderCellId = "teamHeaderCell"
private let teamMemberCellId = "teamMemberCell"
private let startCombatCellId = "startCombatCell"

private let addEditTeamMemberSegueId = "AddEditTeamMemberSegue"
private let combatResultSegueId = "combatResultSegue"

class TeamsEditorTableViewController: UITableViewController, teamHeaderDelegate, NewMemberProtocol {
    
    var team1: TTeam = TTeam(name: "", members: [])
    var team2: TTeam = TTeam(name: "", members: [])
    
    var newMemberTeam: Int? = nil
    
    var editingMemberIndexPath: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadDefaultTeams()
        
        //Remove extra separators
        self.tableView.tableFooterView = UIView()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false;
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        
        //Disable or enable scrolling if the content is bigger than the tableview frame
        if (self.tableView.contentSize.height * 1.1 > self.tableView.frame.size.height) {
            self.tableView.isScrollEnabled = true;
        } else {
            self.tableView.isScrollEnabled = false;
        }
    }
    
    func loadDefaultTeams() {
        
        //Load default teams from JSON files
        let bundle = Bundle(for: type(of: self))
        
        if let team1Url = bundle.url(forResource: "AutoBotsTeam", withExtension: "json") {
            do {
                let jsonContents = try Data(contentsOf: team1Url)
                self.team1 = try JSONDecoder().decode(TTeam.self, from: jsonContents)
            }  catch {
                print("Error parsing Team 1 JSON file")
            }
        }
        
        if let team2Url = bundle.url(forResource: "DecepticonsTeam", withExtension: "json") {
            do {
                let jsonContents = try Data(contentsOf: team2Url)
                self.team2 = try JSONDecoder().decode(TTeam.self, from: jsonContents)
            }  catch {
                print("Error parsing Team 2 JSON file")
            }
        }
    }
    
    
    @IBAction func startCombat(_ sender: Any) {
        //Check if both teams have at least one Transformer
        if team1.members.count > 0 && team2.members.count > 0 {
            //Start fight!
            self.performSegue(withIdentifier: combatResultSegueId, sender: self)
        } else {
            //Woups, both teams need at least one member
            RMessage.showNotification(withTitle: "Both teams need at least one member", subtitle: "", type: .error, customTypeName: "", callback: nil)
        }
        
    }
    
    // MARK: - NewMemberProtocol
    
    func newMember(member: Transformer) {
        //Add or replace transformer in team
        if let indexPath = self.editingMemberIndexPath {
            //We were editing a member - remplace -> since we need to sort the array based on the rank, we delete the old member and we append it (order might not be the same so no need to remplace)
            if self.editingMemberIndexPath?.section == 0 {
                self.team1.members.remove(at: indexPath.row)
            } else {
                self.team2.members.remove(at: indexPath.row)
            }
        }
        
        // add member
        if self.editingMemberIndexPath?.section == 0 || self.newMemberTeam == 0 {
            self.team1.members.append(member)
        } else {
            self.team2.members.append(member)
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - teamHeaderDelegate
    
    func addMember(for team: Int) {
        self.newMemberTeam = team
        self.performSegue(withIdentifier: addEditTeamMemberSegueId, sender: self)
    }
    
    func teamNameChanged(newName: String, team: Int) {
        //Update team name
        if team == 0 {
            self.team1.name = newName
        } else if team == 1 {
            self.team2.name = newName
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //Team 1
            return self.team1.members.count
        } else if section == 1 {
            //Team 2
            return self.team2.members.count
        } else {
            return 1
        }
    }

    func setMemberCell(member: Transformer, cell: TeamMemberTableViewCell) {
        cell.name.text = member.name
        cell.overallRating.text = String(member.overalRating)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            //Team 1
            let cell: TeamMemberTableViewCell = tableView.dequeueReusableCell(withIdentifier: teamMemberCellId, for: indexPath) as! TeamMemberTableViewCell
            self.setMemberCell(member: self.team1.members[indexPath.row], cell: cell)
            return cell
        } else if indexPath.section == 1 {
            //Team 2
            let cell: TeamMemberTableViewCell = tableView.dequeueReusableCell(withIdentifier: teamMemberCellId, for: indexPath) as! TeamMemberTableViewCell
            self.setMemberCell(member: self.team2.members[indexPath.row], cell: cell)
            return cell
        } else {
            //Fight cell
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: startCombatCellId, for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: teamHeaderCellId) as? TeamHeaderTableViewCell else { return nil }
        if section == 0 {
            cell.detailView.teamName.text = self.team1.name
        } else if section == 1 {
            cell.detailView.teamName.text = self.team2.name
        } else {
            return nil
        }
        
        cell.detailView.team = section
        cell.detailView.delegate = self
        
        return cell.contentView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section < 2 ? 113 : 0
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section < 2 ? true : false
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if indexPath.section == 0 {
                self.team1.members.remove(at: indexPath.row)
            } else {
                self.team2.members.remove(at: indexPath.row)
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == combatResultSegueId {
            guard let destVc = segue.destination as? BattleResultViewController else { return }
            destVc.battle = TBattle(team1: self.team1, team2: self.team2)
        } else if segue.identifier == addEditTeamMemberSegueId {
            guard let destVc = segue.destination as? MemberEditorTableViewController else { return }
            destVc.delegate = self
            
            guard let selectedIndexPath = self.tableView.indexPathForSelectedRow else {
                self.editingMemberIndexPath = nil
                return
            }
            //We are editing a member, so we clear newMember team variable to avoid issues
            self.editingMemberIndexPath = selectedIndexPath
            self.newMemberTeam = nil
            
            if selectedIndexPath.section == 0 {
                destVc.member = self.team1.members[selectedIndexPath.row]
            } else if selectedIndexPath.section == 1 {
                destVc.member = self.team2.members[selectedIndexPath.row]
            }
        }
    }
    

}
