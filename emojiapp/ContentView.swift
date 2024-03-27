//
//  ContentView.swift
//  emojiapp
//
//  Created by Ekam Walia on 21/08/22.
//



import SwiftUI

struct ContentView: View {

  @State private var searchText: String = ""

  private var searchResults: [EmojiDetails] {
    let results = EmojiProvider.all()
    if searchText.isEmpty { return results }
    return results.filter {
      $0.name.lowercased().contains(searchText.lowercased()) || $0.emoji.contains(searchText)
    }
  }

  private var suggestedResults: [EmojiDetails] {
    if searchText.isEmpty { return [] }
    return searchResults
  }

  var body: some View {
    NavigationView {
      List(searchResults) { emojiDetails in
        NavigationLink(destination: {
          EmojiDetailsView(emojiDetails: emojiDetails)
        }) {
          Text("\(emojiDetails.emoji) \(emojiDetails.name)")
            .padding(6)
        }
      }
      .navigationTitle("Emoji Search 🔍")
      .searchable(
        text: $searchText,
        placement: .navigationBarDrawer(displayMode: .always),
        prompt: "Search for emoji"
      ) {
        ForEach(suggestedResults) { emojiDetails in
          Text("Looking for \(emojiDetails.emoji)?")
            .searchCompletion(emojiDetails.name)
        }
      }
    }
  }
}

struct EmojiDetailsView: View {

  let emojiDetails: EmojiDetails

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text("\(emojiDetails.emoji) \(emojiDetails.name)")
          .font(.largeTitle)
          .bold()
        Text(emojiDetails.description)
        Spacer()
      }
      Spacer()
    }.padding([.leading, .trailing], 24)
  }
}
