//
//  ReduxStore.swift
//  taken from AtomiCube
//
//  Created by Azzam AL-Rashed on 25/08/2022.
//
/*
 
 The Store stores your entire app state in the form of a single data structure.
 This state can only be modified by dispatching Actions to the store.
 Whenever the state in the store changes, the store will notify all observers.
 
*/

import ReSwift

let ReduxStore = Store<ReduxState>( reducer: reduxReducer, state: nil )

