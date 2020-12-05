module Model exposing (..)

import Http as Http



--- Relations list


relatedToList =
    [ "Bhavpreet"
    , "Natasha"
    ]


relationsList =
    [ "Uncle"
    , "Aunt"
    , "Cousin"
    , "Brother"
    , "Father"
    , "Mother"
    ]


rsvpList =
    [ "Yes"
    , "No"
    ]



---- MODEL ----


type alias Model =
    { name : String
    , age : Maybe Int
    , relation : Maybe String
    , nar : Bool -- Name Age Relation Flag => Indicates they are set
    , relatedTo : Maybe String
    , rsvp : Maybe String
    , awaitResp : Bool -- Flag to wait on submit status
    , tryAgain : Bool -- marker for error, have to try submit again
    , allDone : Bool -- Flag to say all values are set and submitted
    }


type Msg
    = NoOp
    | UpdateName String
    | UpdateAge String
    | UpdateRelation String
    | UpdateRelatedTo String
    | UpdateRSVP String
    | BackToInputRelatedTo
    | BackToInputNAR
    | NextNAR
    | Submit
    | SubmitRet (Result Http.Error String)
    | AddMore
