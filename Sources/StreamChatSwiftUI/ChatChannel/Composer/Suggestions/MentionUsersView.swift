//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import SwiftUI

struct MentionUsersView: View {
    
    @Injected(\.colors) private var colors
    
    private let itemHeight: CGFloat = 60
    
    var users: [ChatUser]
    var userSelected: (ChatUser) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    MentionUserView(
                        user: user,
                        userSelected: userSelected
                    )
                }
            }
            .animation(nil)
        }
        .frame(height: viewHeight)
        .background(Color(colors.background))
        .modifier(ShadowViewModifier())
        .padding(.all, 8)
        .animation(.spring())
    }
    
    private var viewHeight: CGFloat {
        if users.count > 3 {
            return 3 * itemHeight
        } else {
            return CGFloat(users.count) * itemHeight
        }
    }
}

struct MentionUserView: View {
    @Injected(\.fonts) private var fonts
    @Injected(\.colors) private var colors

    var user: ChatUser
    var userSelected: (ChatUser) -> Void
    
    var body: some View {
        HStack {
            MessageAvatarView(
                author: user,
                showOnlineIndicator: true
            )
            Text(user.name ?? user.id)
                .lineLimit(1)
                .font(fonts.bodyBold)
            Spacer()
            Text("@")
                .font(fonts.title)
                .foregroundColor(colors.tintColor)
        }
        .standardPadding()
        .onTapGesture {
            userSelected(user)
        }
    }
}