module Model exposing (..)

import Http as Http



--- Relations list


relatedToList =
    [ "Bhavpreet"
    , "Natasha"
    ]


defaultRelationsList =
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


type alias Window =
    { width : Int
    , height : Int
    }



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
    , relationsList : List String
    , showRelationText : Bool
    , infoOK : Bool
    , window : Window
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
    | SubmitRelationRet (Result Http.Error String)
    | AddMore
    | FetchRelations (Result Http.Error String)
    | ViewportChange Window
    | InfoOK
