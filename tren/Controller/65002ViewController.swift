//
//  65002ViewController.swift
//  tren
//
//  Created by Hasan onur Can on 3.02.2022.
//

import UIKit

class _5002ViewController: UIViewController {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var aylıkOrtalamaKm: UILabel!
    
    @IBOutlet weak var kmTextField: UITextField!
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    var data = [KmVerisi]()
    var total = 0
    var aytotal = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CellTableViewCell", bundle: nil), forCellReuseIdentifier: "ToCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        loadItems()
        tot()
        
        
        
    }
    
    
    @IBAction func editPressed(_ sender: Any) {
        
        
        setEditing(isEditing, animated: true)
        
    }
    
    
    @IBAction func addPressed(_ sender: UIButton) {
        
        print(createArray())
        
        
        total+=Int(kmTextField.text!)!
        aytotal+=Int(kmTextField.text!)!
        
        saveItems()
        ayTotalSıfır()
        
        tableView.reloadData()
        
        totalLabel.text = String( total)
        print(aytotal)
        print(Int(data[data.count-1].gün.suffix(2))!)
        aylıkOrtalamaKm.text = String(aytotal/Int(data[data.count-1].gün.suffix(2))!)
        
        
        
        if total>=260{
            uyarı()
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath = IndexPath(row: self.data.count - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
        
        
        
        
    }
    
    func ayTotalSıfır(){
        let startIndex = data[data.count-1].gün.index(data[data.count-1].gün.startIndex, offsetBy: 14)
        let endIndex = data[data.count-1].gün.index(data[data.count-1].gün.startIndex, offsetBy: 15)
        print(String(data[data.count-1].gün[startIndex...endIndex]) )
        
        
        if data.count > 1{
            if String(data[data.count-1].gün[startIndex...endIndex]) != String(data[data.count-2].gün[startIndex...endIndex]){
                aytotal=0
                aytotal+=Int(kmTextField.text!)!
                
            
            }else{
                return
            }
            
        }
        
        
        
    }
    
    
    
    func tot(){
        for a in data{
            total += a.günlükKm
            
        }
        
    }
    
    
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do{
            let dataa = try encoder.encode(data)
            try dataa.write(to:self.dataFilePath!)
        }catch{
            print(error)
        }
        
        
    }
    
    
    func loadItems() {
        
        if let dataa = try? Data(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
            do {
                
                data = try decoder.decode([KmVerisi].self, from: dataa)
                
            }catch{
                print(error)
            }
        }
        
    }
    
    
    
    
    
    func createArray() ->[KmVerisi]{
        let a = Int(kmTextField.text!)
        let b = Date.getCurrentDate()
        let c = KmVerisi(günlükKm:a!, gün: b)
        data.append(c)
        return data
        
        
    }
    func uyarı (){
        let alert = UIAlertController(title: "BAKIM ZAMANI", message: "B1 BAKIM ZAMANI GELMİŞTİR. LÜTFEN BAKIM PLANLAYINIZ.", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            
            
            
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
}


extension _5002ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToCell", for: indexPath) as! CellTableViewCell
        cell.lblKm.text =  String( data[indexPath.row].günlükKm)
        cell.lblTarih.text = String( data[indexPath.row].gün)
       
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
       
        return cell
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
            saveItems()
    
    
        }
        }
}




extension Date {
    
    static func getCurrentDate() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        
        return dateFormatter.string(from: Date())
        
    }
}
