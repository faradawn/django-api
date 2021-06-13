//
//  EditView.swift
//  Cherry Learn
//
//  Created by faradawn on 2021/6/13.
//

import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var user: Users
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Username: ", text: $user.username)
                    TextField("Email: ", text: $user.email)
                    TextField("Phone: ", text: $user.phone)
                    TextField("Password: ", text: $user.password)
                    Image(systemName: "square")
                }
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Edit User")
            .navigationBarItems(
                leading: Button("Cancel"){presentationMode.wrappedValue.dismiss()},
                trailing: Button(action: {updateUser()}, label: {Text("Save")})
            )
            
            
        }
    }
    
    func updateUser(){
        guard let users_url = URL(string: "http://127.0.0.1:8000/myapi/users/\(self.user.id)/") else {
            print("updata user: myapi is crashed")
            fatalError("endpoint not active")
        }
        
        
        let accountData = self.user
        guard let encoded = try? JSONEncoder().encode(accountData) else {
            print("fail to encode")
            return
        }
        
        
        var request = URLRequest(url: users_url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Basic RmFyYWRhd246MTIzNDU2", forHTTPHeaderField: "Authorization")
        request.httpBody = encoded
        
        
        URLSession.shared.dataTask(with: request){
            data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    print("\(data)")
                    presentationMode.wrappedValue.dismiss()
                }
                return
            }
        }.resume()
        // end url session
    }

}
