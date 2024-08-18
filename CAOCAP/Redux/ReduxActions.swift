//
//  ReduxActions.swift
//  taken from AtomiCube
//
//  Created by Azzam AL-Rashed on 25/08/2022.
//
/*
 
 Actions are a declarative way of describing a state change.
 Actions don't contain any code, they are consumed by the store and forwarded to reducers.
 Reducers will handle the actions by implementing a different state change for each action.
 
*/


import ReSwift
import SwiftSoup

// MARK: User Actions
struct AuthUserAction: Action { let user: User }
struct SubscribeAction: Action { let subscriptionStatus: Bool }

struct ReceivedCommitHistoryAction: Action { let commits: [String] }

// MARK: Daily Challenges
struct ChallengeCompletedAction: Action { let challenge: Challenge }

// MARK: Project Actions
struct CreateProjectAction: Action { let newProject: Project } 
struct DeleteProjectAction: Action {}

struct OpenProjectAction: Action {}
struct CloseProjectAction: Action {}

struct UpdateSelectedElementAction: Action { let selectedID: String }

struct UpdateProjectLangAction: Action { let lang: String }
struct UpdateProjectTitleAction: Action { let title: String }

// MARK: Undo/Redo Actions
struct UpdateAction: Action { let handler: ()->Void }  // call this action before the document is edited to save last state
struct WillEditAction: Action {}
struct UndoAction: Action {}
struct RedoAction: Action {}
