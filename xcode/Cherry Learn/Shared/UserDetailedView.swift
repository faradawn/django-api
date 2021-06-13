//
//  UserDetailedView.swift
//  Cherry Learn
//
//  Created by faradawn on 2021/6/13.
//


import SwiftUI

struct UserDetailedView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var users: Users
    @State var showEdit = false
    
    var body: some View {
        List{
            Section{
                Text("Username: \(users.username)")
                Text("Email: \(users.email)")
                Text("Phone: \(users.phone)")
                Text("Password: \(users.password)")
            }
            Section{
                Button(action: {self.deleteUser()}, label: {
                    HStack{
                        Image(systemName: "trash")
                        Text("Delete User")
                    }
                })
                // end button
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(users.username)
        .navigationBarItems(trailing: Button(action: {self.showEdit.toggle()}, label: {
            Text("Edit")
                .sheet(isPresented: $showEdit, content: {EditView(user: $users)})
        }))
    }
    
    func deleteUser(){
        guard let users_url = URL(string: "http://127.0.0.1:8000/myapi/users/\(self.users.id)/") else {
            print("myapi is crashed")
            return
        }
        
        var request = URLRequest(url: users_url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Basic RmFyYWRhd246MTIzNDU2", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    print("\(data)")
                    self.presentationMode.wrappedValue.dismiss()
                }
                return
            }
        }.resume()
        
    } // end function
    
}

struct UserDetailedView_Previews: PreviewProvider {
    static var previews: some View{
        UserDetailedView(users: Users(id: 0, username: "username1", email: "eamil", phone: "1231", password: "asd1"))
    }
}
