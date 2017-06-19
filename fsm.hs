{-# OPTIONS_GHC -Wall #-}
module FSM where

import Control.Monad (foldM)

data State = Asleep | Awake | Dressed | Fed | Ready | Work | Cafe | Home | Invalid
    deriving (Show, Eq)

data Event = Alarm | Dress | Eat | GoToWork | Think | Yawn | Coffee | GoHome | Read | WatchTV
    deriving (Show, Eq)

-- Transition function (aka. transition table)
transition :: (State, Event) -> State
transition (Asleep,  Alarm)    = Awake
transition (Awake,   Dress)    = Dressed
transition (Awake,   Eat)      = Fed
transition (Dressed, Eat)      = Ready
transition (Fed,     Dress)    = Ready
transition (Ready,   GoToWork) = Work
transition (Work,    Think)    = Work
transition (Work,    Yawn)     = Cafe
transition (Cafe,    Coffee)   = Work
transition (Work,    GoHome)   = Home
transition (Home,    Read)     = Asleep
transition (Home,    WatchTV)  = Asleep
transition (_, _)              = Invalid

-- Decouple the machine from the transition function
fsm :: ((State, Event) -> State) -> (State, Event) -> Maybe State
fsm t = \(s, e) -> case t (s, e) of
    Invalid  -> Nothing
    newState -> Just newState

runFrom :: State -> [Event] -> Maybe State
runFrom state = foldM (curry $ fsm transition) state
