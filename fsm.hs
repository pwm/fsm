{-# OPTIONS_GHC -Wall #-}
module FSM where

import Control.Monad (foldM)

data State = Asleep | Awake | Dressed | Fed | Ready | Work | Cafe | Home | Invalid
    deriving (Show, Eq)

data Event = Alarm | Dress | Eat | GoToWork | Think | Yawn | Coffee | GoHome | Read | WatchTV
    deriving (Show, Eq)

-- Transition function (aka. transition table)
myDay :: (State, Event) -> State
myDay (Asleep,  Alarm)    = Awake
myDay (Awake,   Dress)    = Dressed
myDay (Awake,   Eat)      = Fed
myDay (Dressed, Eat)      = Ready
myDay (Fed,     Dress)    = Ready
myDay (Ready,   GoToWork) = Work
myDay (Work,    Think)    = Work
myDay (Work,    Yawn)     = Cafe
myDay (Cafe,    Coffee)   = Work
myDay (Work,    GoHome)   = Home
myDay (Home,    Read)     = Asleep
myDay (Home,    WatchTV)  = Asleep
myDay (_, _)              = Invalid

-- The machine decoupled from the specific transition function
fsm :: ((State, Event) -> State) -> (State, Event) -> Maybe State
fsm t = \(s, e) -> case t (s, e) of
    Invalid  -> Nothing
    newState -> Just newState

-- Running the simulation with a transition function, an initial state and a list of events
run :: ((State, Event) -> State) -> State -> [Event] -> Maybe State
run t s = foldM (curry $ fsm t) s
