//
//  ContentView.swift
//  Shared
//
//  Created by faradawn on 2021/6/11.
//

import SwiftUI

struct ContentView: View {
    @State var users = [Users]()
    // view render
    var body: some View {
        ForEach(users, id: \.self) {
            item in HStack{
                Image(systemName: "banknote").foregroundColor(.green)
                Text(item.username)
                Text("\(item.email)")
            }
        }.onAppear(perform: loadAccount)
    }
    // fetch data
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
