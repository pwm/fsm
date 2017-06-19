{-# OPTIONS_GHC -Wall #-}
module FSM where

import Control.Monad (foldM)

data State = Awake | Dressed | Fed | Ready | Work | Cafe | Home | Asleep
    deriving (Show, Eq)

data Event = Alarm | Dress | Eat | GoToWork | Think | Yawn | Coffee | GoHome | Read | WatchTV
    deriving (Show, Eq)

-- Transition function (aka. transition table)
myDay :: (State, Event) -> Maybe State
myDay (Asleep,  Alarm)    = Just Awake
myDay (Awake,   Dress)    = Just Dressed
myDay (Awake,   Eat)      = Just Fed
myDay (Dressed, Eat)      = Just Ready
myDay (Fed,     Dress)    = Just Ready
myDay (Ready,   GoToWork) = Just Work
myDay (Work,    Think)    = Just Work
myDay (Work,    Yawn)     = Just Cafe
myDay (Cafe,    Coffee)   = Just Work
myDay (Work,    GoHome)   = Just Home
myDay (Home,    Read)     = Just Asleep
myDay (Home,    WatchTV)  = Just Asleep
myDay (_, _)              = Nothing

-- The machine decoupled from the specific transition function
fsm :: ((State, Event) -> Maybe State) -> (State, Event) -> Maybe State
fsm t (s, e) = t (s, e)

-- Running the simulation with a transition function, an initial state and a list of events
run :: ((State, Event) -> Maybe State) -> State -> [Event] -> Maybe State
--run t s = foldl (curry $ fsm t) s
run t s = foldM (curry $ fsm t) s
