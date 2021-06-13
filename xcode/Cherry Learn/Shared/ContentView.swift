//
//  ContentView.swift
//  Shared
//
//  Created by faradawn on 2021/6/11.
//

import SwiftUI

struct ContentView: View {
    @State var users = [Users]() // change to users: Users
    @State var showAdd = true
    
    // view
    var body: some View {
        NavigationView{
            List{
                ForEach(users) {
                    item in HStack{
                        NavigationLink( destination: UserDetailedView(users: item)){
                            Image(systemName: "banknote").foregroundColor(.green)
                            Text(item.username)
                            Text("\(item.email)")
                        }
                        
                    }
                }
                
            }
            .onAppear(perform: loadAccount)
            .navigationBarTitle("Users")
            .navigationBarItems(trailing: Button(action: {showAdd.toggle()}, label: {
                Image(systemName: "circle")
            }))
            .sheet(isPresented: $showAdd, content: {
                AddView(functionCall: self.loadAccount)
            })
            
            
        }
        
        
    }
    
    
    
    // load account
    func loadAccount() {
        guard let users_url = URL(string: "http://127.0.0.1:8000/myapi/users/") else {
            print("myapi is crashed")
            return
        }
        var request = URLRequest(url: users_url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Basic RmFyYWRhd246MTIzNDU2", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){
            data, response, error in
            if let data = data {
                if let response = try?
                    JSONDecoder().decode(
                        [Users].self, from: data){
                    DispatchQueue.main.async {
                        self.users = response
                    }
                    return
                }
            }
        }.resume()
        
    }
}

struct AddView : View {
    @Environment(\.presentationMode) var presentationMode
    @State var username: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var password: String = ""
    
    var functionCall: () -> Void
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Username: ", text: $username)
                    TextField("Email: ", text: $email)
                    TextField("Phone: ", text: $phone)
                    TextField("Password: ", text: $password)
                    Image(systemName: "square")
                }
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Add User")
            .navigationBarItems(
                leading: Button("Cancel"){presentationMode.wrappedValue.dismiss()},
                trailing: Button(action: {postAccount()}, label: {Text("Save")})
            )
            
            
        }
    }
    
    func postAccount(){
        guard let users_url = URL(string: "http://127.0.0.1:8000/myapi/users/") else {
            print("myapi is crashed")
            return
        }
        
        let accountData = Users(id: 0, username: self.username, email: self.email, phone: self.phone, password: self.password)
        // need created_at: "" ?
        
        guard let encoded = try? JSONEncoder().encode(accountData) else {
            print("fail to encode")
            return
        }
        
        
        var request = URLRequest(url: users_url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Basic RmFyYWRhd246MTIzNDU2", forHTTPHeaderField: "Authorization")
        request.httpBody = encoded
        
        
        URLSession.shared.dataTask(with: request){
            data, response, error in
            if let data = data {
                
                    DispatchQueue.main.async {
                        print("\(data)")
                        self.functionCall()
                        presentationMode.wrappedValue.dismiss()
                    }
                    return
                
            }
        }.resume()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
