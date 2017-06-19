# A simple state machine example in Haskell

## To run

    $ stack ghci
    > run myDay Asleep [Alarm, Eat, Dress, GoToWork, Think, Think, Yawn, Coffee, Think, Yawn]
    Just Cafe
    > run myDay Work [WatchTV]
    Nothing

## The machine

![](https://cdn.rawgit.com/pwm/fsm/master/diagram/fsm.svg)
