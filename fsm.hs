{-# OPTIONS_GHC -Wall #-}
module FSM where

import Control.Monad (foldM)

data State
    = Asleep
    | Awake
    | Dressed
    | Fed
    | Ready
    | Work
    | Cafe
    | Home
    | Invalid
    deriving (Show, Eq)

data Event
    = Alarm
    | Dress
    | Eat
    | GoToWork
    | Think
    | Yawn
    | Coffee
    | GoHome
    | Read
    | WatchTV
    deriving (Show, Eq)

-- Transition table
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

-- Lift the TT into Maybe
lift :: (a -> State) -> (a -> Maybe State)
lift f = \a -> case f a of
    Invalid -> Nothing
    x       -> Just x

-- run [Alarm, Eat, Dress, GoToWork, Think, Think, Yawn, Coffee, Think, Yawn, Coffee, GoHome, Read]
run :: [Event] -> Maybe State
run = foldM (curry $ lift transition) Asleep

--run2 :: [Maybe Event] -> Maybe State
--run2 = foldl (liftA2 $ curry transition) (Just S0)


