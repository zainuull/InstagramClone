//
//  ContentView.swift
//  InstagramFull
//
//  Created by Zainul on 22/06/23.
//

import SwiftUI


struct DataModel : Identifiable {
    let id : String = UUID().uuidString
    let name : String
    let username : String
    let image : String
    let image2 : String
    let image3 : String
    let postCount : Int
    let followerCount : Int
    let followingCount : Int
    let isVerifed : Bool = false
}


struct DataImage : Identifiable {
    let id : String = UUID().uuidString
    let image1 : String
    let image2 : String
    let image3 : String
}

class DataUser : ObservableObject {
    @Published var dataModel : [DataModel] = []
    @Published var dataImageSearch : [DataImage] = []
    @Published var textFieldText : String = ""
    
    init() {
        getUser()
        getImageSearch()
    }
    
    func getImageSearch() {
        let data1 = DataImage(image1: "foto1", image2: "foto2", image3: "foto3")
        let data2 = DataImage(image1: "foto4", image2: "foto5", image3: "foto6")
        let data3 = DataImage(image1: "foto7", image2: "foto8", image3: "foto9")
        let data4 = DataImage(image1: "foto10", image2: "foto11", image3: "foto12")
        let data5 = DataImage(image1: "foto13", image2: "foto14", image3: "foto15")
        let data6 = DataImage(image1: "foto16", image2: "foto17", image3: "foto18")
        
        // Append
        dataImageSearch.append(data1)
        dataImageSearch.append(data2)
        dataImageSearch.append(data3)
        dataImageSearch.append(data4)
        dataImageSearch.append(data5)
        dataImageSearch.append(data6)
    }
    
    func getUser() {
        let zainul = DataModel(name: "Zainul", username: "zainuull_", image: "zainul", image2: "foto1", image3: "foto2", postCount: 1, followerCount: 1000, followingCount: 1)
        
        let ahmad = DataModel(name: "ahmad", username: "ahmad", image: "foto1", image2: "foto2", image3: "foto3", postCount: 1, followerCount: 500, followingCount: 10)
        
        let saep = DataModel(name: "Unaa", username: "saep", image: "foto2", image2: "foto3", image3: "foto4", postCount: 1050, followerCount: 790, followingCount: 100)
        
        let ucup = DataModel(name: "Alysa", username: "ucup", image: "foto3", image2: "foto4", image3: "foto5", postCount: 100, followerCount: 2000, followingCount: 20)
        
        let ari = DataModel(name: "Dasha", username: "ari", image: "foto4", image2: "foto5", image3: "foto6", postCount: 10, followerCount: 900, followingCount: 20)
        
        let bintang = DataModel(name: "Bintang", username: "bintang", image: "foto5", image2: "foto6", image3: "foto7", postCount: 10, followerCount: 900, followingCount: 20)
        
        let candra = DataModel(name: "Candra", username: "candra", image: "foto6", image2: "foto7", image3: "foto8", postCount: 2, followerCount: 50, followingCount: 10)
        
        let diki = DataModel(name: "Diki", username: "diki", image: "foto7", image2: "foto9", image3: "foto10", postCount: 2, followerCount: 40, followingCount: 5)
        
        let elang = DataModel(name: "Elang", username: "elang", image: "foto8", image2: "foto9", image3: "foto11", postCount: 2, followerCount: 90, followingCount: 2)
        
        // Append
        dataModel.append(zainul)
        dataModel.append(ahmad)
        dataModel.append(saep)
        dataModel.append(ucup)
        dataModel.append(ari)
        dataModel.append(bintang)
        dataModel.append(candra)
        dataModel.append(diki)
        dataModel.append(elang)
    }
    
    func getAction() -> ActionSheet {
        let save : ActionSheet.Button = .default(Text("Save"))
        let hidden : ActionSheet.Button = .default(Text("Hidden"))
        let edit : ActionSheet.Button = .default(Text("Edit"))
        let delete : ActionSheet.Button = .destructive(Text("Delete"))
        let cancel : ActionSheet.Button = .cancel()
        
        return ActionSheet(
            title: Text(""),
            message: nil,
            buttons: [save, hidden, edit, delete, cancel]
        
        )
    }
}

struct ContentView: View {
    
    @StateObject var dataUser : DataUser = DataUser()
    @State var isScroll : Bool = false
    
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom){
                Color.black.ignoresSafeArea()
                
                Menu(dataUser: dataUser)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10){
                        /// STORIES
                        Stories()
                        
                        //Line Gray
                        LineGray()
                            .offset(y:-15)

                        
                        // Feed
                        VStack(spacing: 30) {
                            Feed(likeCount: 270, image: "zainul", caption: "This is Instagram")
                                .onTapGesture {
                                    isScroll.toggle()
                                }
                            Feed(likeCount: 370, image: "basyar", caption: "This is me")
                        }
                        
                        // Rekomendasi
                        VStack {
                            HStack {
                                Text("Recommended to you")
                                    .font(.headline)
                                Spacer()
                                Text("See All")
                                    .foregroundColor(.blue)
                            }.padding(.horizontal)
                            ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(dataUser.dataModel) { data in
                                            rekomendasi(image: data.image, image2: data.image2, image3: data.image3, username: data.username)
                                        }
                                    }
                            }
                        }
                        .padding(.vertical)
                        .background(Color("custom"))

                        
                        Feed(likeCount: 410, image: "thoba", caption: "Skuuy")
                            .padding(.top,8)
                    }
                    
                }

            }
            .foregroundColor(.white)
            .navigationBarItems(
                    leading:
                        LeadingView(isScroll: $isScroll),
                    trailing:
                        TrailingView(dataUser: dataUser, isScroll: $isScroll)
            ).foregroundColor(.white)
            .environmentObject(dataUser)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //Profil()
    }
}

struct LeadingView: View {
    
    @Binding var isScroll : Bool
    
    var body: some View {
        Text("Instagram")
            .font(.system(size: 30, weight: .semibold))
            .foregroundColor(isScroll ? .black : .white)
        
    }
}

struct TrailingView: View {
    
    @ObservedObject var dataUser : DataUser
    @Binding var isScroll : Bool
    
    var body: some View {
        HStack{
            NavigationLink{
                Notifikasi(dataUser: dataUser)
            } label: {
                Image(systemName: "heart")
            }
            
            NavigationLink{
                MessageView(dataUser: dataUser)
            } label: {
                Image(systemName: "ellipsis.message")
            }
        }.font(.system(size: 18)).foregroundColor(isScroll ? .black : .white)
    }
}

// MARK: MESSAGE
struct MessageView : View {
    
    @ObservedObject var dataUser : DataUser
    @Environment (\.presentationMode) var presentationMode
    
    var body : some View{
        NavigationView{
            ZStack{
                Color.black.ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack{
                        SearchText()
                            .padding(.top)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(dataUser.dataModel) { user in
                                    VStack {
                                        Photo(image: user.image, lineWidth: 0, width: 100, height: 100)
                                        Text(user.username)
                                    }
                                }
                            }.padding(.leading).padding(.vertical)
                        }
                        
                        HStack{
                            Text("Pesan")
                                .fontWeight(.semibold)
                            Image(systemName: "i.circle")
                                .font(.headline)
                            Spacer()
                            Text("Permintaan")
                                .foregroundColor(.blue)
                        }.padding(.horizontal).font(.title3)
                        
                        ForEach(dataUser.dataModel) { user in
                            HStack(spacing: 20){
                                Photo(image: user.image, lineWidth: 0, width: 70, height: 70)
                                VStack(alignment: .leading) {
                                    Text(user.username)
                                    Text("Aktif 3 jam yang lalu")
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Image(systemName: "camera")
                            }.padding(.horizontal)
                        }
                    }
                }
            }
            .navigationBarItems(
                leading:
                    HStack(spacing: 20) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20, weight: .semibold))
                        }


                        Text("zainuull_")
                            .font(.system(size:30, weight: .semibold))
                    }
                    
                    ,
                trailing:
                    HStack{
                        Image(systemName: "plus.rectangle")
                        Image(systemName: "square.and.pencil")
                    }
            )
        }.foregroundColor(.white)

    }
}

// MARK: STORIES
struct Stories: View {
    
    @EnvironmentObject var dataUser : DataUser
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(dataUser.dataModel) { user in
                    VStack {
                        Photo(image: user.image, lineWidth: 8, width: 100, height: 100)
                        
                        Text(user.username)
                            .font(.system(size: 14))
                    }
                }
            }.padding(.leading).padding(.vertical)
        }
    }
}

// MARK: PHOTO
struct Photo: View {
    
    let image : String
    let lineWidth : CGFloat
    let width : CGFloat
    let height : CGFloat
    
    var body: some View {
        Circle()
            .stroke(
                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red, Color.purple]), startPoint: .bottomLeading, endPoint: .topTrailing),
                lineWidth : lineWidth
            )
            .overlay(
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            )
            .frame(width: width, height: height)
    }
}

// MARK: NOTIFIKASI
struct Notifikasi : View {
    
    @ObservedObject var dataUser : DataUser
    
    var body : some View {
        NavigationView{
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView{
                    VStack(spacing: 20){
                        ForEach(dataUser.dataModel) { data in
                            PersonalFotif(image: data.image, username: data.username)
                        }
                    }.padding(.top)
                }
                .navigationBarItems(
                    leading:
                        Text("Notifikasi")
                            .fontWeight(.bold)
                    , trailing:
                        Button(action: {
                            
                        }, label: {
                            Text("Filter")
                                .font(.title3)
                                .foregroundColor(.blue)
                        })
            ).font(.title)
            }.foregroundColor(.white)
        }
    }
}

struct PersonalFotif: View {
    @State var isFollow : Bool = false
    
    let image : String
    let username : String
    
    var body: some View {
        HStack(spacing: 15){
            Photo(image: image, lineWidth: 5, width: 65, height: 65)
            
            
            HStack {
                Text("\(username) mulai mengikuti Anda. 5 hari")
                    .font(.system(size: 15))
            }
            
            Spacer()
            
            Button {
                isFollow.toggle()
            } label: {
                Text(isFollow ? "Followed" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,14)
                    .padding(.horizontal,25)
                    .background(isFollow ? .gray : .blue)
                    .cornerRadius(20)
            }
            
        }.padding(.horizontal,5)
    }
}

// MARK: FEED
struct Feed: View {
    
    @EnvironmentObject var dataUser : DataUser
    
    @State var likeCount : Int
    @State var isLike : Bool = false
    @State var isSave : Bool = false
    @State var isLoading : Bool = false
    @State var isActionSheet : Bool = false
    
    let image : String
    let caption : String
    
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing: 20){
                Photo(image: "zainul", lineWidth: 5, width: 30, height: 30)
                Text("zainuull_")
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.blue)
                Spacer()
                Button {
                    isActionSheet.toggle()
                } label: {
                    Image(systemName: "text.alignright")
                }
            }
            .padding(.horizontal)
            .actionSheet(isPresented: $isActionSheet) {
                dataUser.getAction()
            }
            
            ZStack(alignment: .bottom) {
                Image(image)
                    .resizable()
                    .aspectRatio(1.0,contentMode: .fill)
                    .onTapGesture(count: 2) {
                        isLike.toggle()
                        if isLike {
                            likeCount += 1
                        } else {
                            likeCount -= 1
                        }
                    }
                
                Rectangle()
                    .fill(Color.gray)
                    .overlay(
                        Text("Saved")
                            .font(.headline)
                            .offset(x:120)
                    )
                    .frame(height: 50)
                    .offset(x: isSave ? 0 : -400)
                    .animation(.linear)
            }
            
            HStack(spacing: 15){
                Image(systemName: isLike ? "heart.fill" : "heart")
                    .foregroundColor(isLike ? .red : .white)
                    .onTapGesture {
                        isLike.toggle()
                        if isLike {
                            likeCount += 1
                        } else {
                            likeCount -= 1
                        }
                    }
                Image(systemName: "message")
                Image(systemName: "paperplane")
                Spacer()
                Image(systemName: isSave ? "bookmark.fill" : "bookmark")
                    .onTapGesture {
                        isSave.toggle()
                    }
            }.padding(.horizontal).padding(.vertical,3).font(.system(size: 22))
            
            Text("\(likeCount) Like")
                .font(.headline)
                .padding(.leading)
                .offset(y:-8)
            
            HStack(spacing: 15){
                Text("zainuull__")
                    .font(.headline)
                Text("This is Instagram Clone")
            }.padding(.leading).offset(y:-8)
            
            Text("See All Comment")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.leading,8)
            
            HStack(spacing: 15){
                Photo(image: "zainul", lineWidth: 3, width: 20, height: 20)
                ZStack(alignment: .leading) {
                    TextField("", text: $dataUser.textFieldText)
                    Text("See all 100 Comment")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Text("❤️")
                Text("🙌")
                Image(systemName: "plus.circle")
            }.padding(.horizontal).offset(y:-5)
            
        }
        
    }
}

struct LineGray: View {
    var body: some View {
        Rectangle()
            .fill(.gray.opacity(0.3))
            .frame(height: 1)
    }
}

// MARK: MENU
struct Menu: View {
    
    @ObservedObject var dataUser : DataUser
    
    var body: some View {
        HStack{
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red, Color.purple]), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth : 5
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.black)
                    )
                    .frame(width: 310, height: 70)
                
                HStack(spacing: 30){
                    NavigationLink {
                        ContentView()
                    } label: {
                        Image(systemName: "house.fill")
                    }
                    
                    NavigationLink {
                        Search(dataUser: dataUser)
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    
                    NavigationLink {
                        Text("Add")
                    } label: {
                        Image(systemName: "plus.app")
                    }
                    
                    NavigationLink {
                        Text("Reels")
                    } label: {
                        Image(systemName: "play.square")
                    }
                    
                    NavigationLink {
                        Profil(dataUser: dataUser)
                    } label: {
                        Photo(image: "zainul", lineWidth: 0, width: 30, height: 30)
                    }
                    
                    
                }.font(.title2)
            }
            
        }
        .zIndex(10)
    }
}

// MARK: SEARCH
struct Search : View {
    
    @ObservedObject var dataUser : DataUser

    let columns : [GridItem] = [
        GridItem(.flexible(),spacing: 5, alignment: nil),
        GridItem(.flexible(),spacing: 5, alignment: nil),
        GridItem(.flexible(),spacing: 0, alignment: nil),
    ]
    
    var body : some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()
            
            Menu(dataUser: dataUser)
            
            ScrollView{
                LazyVStack{
                    SearchText()
                    LazyVGrid(columns: columns, spacing: 3) {
                        ForEach(dataUser.dataImageSearch) { data in
                            Grid(image: data.image1, height: 300)
                        }
                        ForEach(dataUser.dataImageSearch) { data in
                            Grid(image: data.image2, height: 200)
                        }
                        ForEach(dataUser.dataImageSearch) { data in
                            Grid(image: data.image3, height: 300)
                        }
                    }
                }
            }
        }.foregroundColor(.white)
    }
}

struct Grid: View {
    @State var image : String
    @State var height :CGFloat
    
    var body: some View {
        Rectangle()
            .overlay(
                Image(image)
                    .resizable()
                
            )
            .frame(height: height)
    }
}

struct SearchText: View {
    
    @State var textFieldText : String = ""
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $textFieldText)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal,40)
                .padding(.vertical,12)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
                .padding(.horizontal)
            HStack {
                Text("Cari")
                    .offset(x:60)
                Image(systemName: "magnifyingglass")
                    .offset(x:-10)
            }.foregroundColor(.gray)
        }
    }
}


//MARK: PROFIL
struct Profil : View {
    
    @State var isSelected : Bool = false
    
    let insight : [String] = [
        "Mobile Dev", "Swift UI", "Web Dev", "main", "ngoding", "working", "learning", "trading", "editing"
    ]
    
    let column : [GridItem] = [
        GridItem(.flexible(),spacing: 0, alignment: nil),
        GridItem(.flexible(),spacing: 0, alignment: nil),
        GridItem(.flexible(),spacing: 0, alignment: nil),
    ]
    
    @ObservedObject var dataUser : DataUser
    
    
    var body : some View {

        NavigationView{
            ZStack(alignment: .bottom){
                Color.black.ignoresSafeArea()
                
                Menu(dataUser: dataUser)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading){
                        HStack(spacing: 15){
                            Photo(image: "zainul", lineWidth: 0, width: 100, height: 100)
                            Spacer()
                            VStack{
                                Text("3")
                                    .font(.headline)
                                Text("Postingan")
                            }
                            VStack{
                                Text("7.9 M")
                                    .font(.headline)
                                Text("Followers")
                            }
                            VStack{
                                Text("359")
                                    .font(.headline)
                                Text("Following")
                            }
                        }.font(.system(size:14)).padding(.horizontal)
                        
                        HStack(spacing: 15) {
                            Text("Zainul")
                                .font(.headline)
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                        }.padding(.horizontal)
                        Text("The more you learn the more you earn")
                            .padding(.horizontal)
                        
                        
                        HStack(spacing: 20){
                            Text("Edit Profil")
                                .font(.headline)
                                .frame(width: 150, height: 40)
                                .background(Color("custom")).cornerRadius(10)
                            
                            Text("Bagikan Profil")
                                .font(.headline)
                                .frame(width: 150, height: 40)
                                .background(Color("custom")).cornerRadius(10)
                            
                            Image(systemName: "person.badge.plus")
                                .font(.headline)
                                .frame(width: 50, height: 40)
                                .background(Color("custom")).cornerRadius(10)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15){
                                ForEach(insight, id: \.self) { data in
                                    VStack {
                                        Photo(image: "zainul", lineWidth: 0, width: 85, height: 85)
                                        Text(data)
                                            .font(.system(size: 14))
                                    }
                                }
                            }
                        }.padding(.leading).padding(.vertical)
                        
                        HStack(spacing: 200){
                            Image(systemName: "rectangle.grid.2x2")
                                .font(isSelected ? .none : .headline)
                                .fontWeight(isSelected ? .none : .bold)
                                .onTapGesture {
                                   isSelected = false
                                }
                            
                            Image(systemName: "person.crop.square")
                                .font(isSelected ? .headline : .none)
                                .fontWeight(isSelected ? .bold : .none)
                                .onTapGesture {
                                    isSelected = true
                                }
                        }
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        
                        Rectangle()
                            .fill(.white.opacity(0.8))
                            .frame(width: UIScreen.main.bounds.width * 0.5, height: 3)
                            .offset(x: isSelected ? 200 : 0,y:-10)
                            .animation(Animation.spring())
                        
                        
                        LazyVGrid(columns: column, spacing: 0) {
                            Grid(image: "feed1", height: 150)
                            Grid(image: "thoba", height: 150)
                            Grid(image: "basyar", height: 150)
                        }.offset(y:-17)
                        
                    }
                }
                    
            }
            .navigationBarItems(
                leading:
                   Text("zainuull_")
                    .font(.system(size: 30, weight: .semibold))

                    ,
                trailing:
                    HStack(spacing: 20){
                        Image(systemName: "plus.app")
                        Image(systemName: "text.justify")
                    }
            )
        }.foregroundColor(.white)
    }
}

//MARK: REKOMENDASI
struct rekomendasi: View {
    
    @State var isFollow : Bool = false
    let image : String
    let image2 : String
    let image3 : String
    let username : String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .overlay(
                    Rectangle()
                        .stroke(Color.gray.opacity(0.8))
                )
                .frame(width: 250, height: 250)
            
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .offset(x:100, y:-110)
            
            VStack {
                Photo(image: image, lineWidth: 0, width: 100, height: 100)
                Text(username)
                    .font(.headline)
                
                HStack(alignment: .center, spacing: 20) {
                    ZStack {
                        Photo(image: image2, lineWidth: 0, width: 20, height: 20)
                        Photo(image: image3, lineWidth: 0, width: 20, height: 20)
                            .offset(x:5, y:10)
                    }
                    Text("Diikuti oleh ahmad, saep + 3 lainnya ")
                        .font(.caption)
                        .foregroundColor(.gray)
                }.frame(width: 150).offset(y:-5)
                
                Button {
                    isFollow.toggle()
                } label: {
                    Text(isFollow ? "Followed" : "Follow")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.5, height: 35)
                        .background(isFollow ? .gray : .blue).cornerRadius(10)
                    
                }
            }
        }
    }
}
