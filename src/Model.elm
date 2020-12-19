module Model exposing (..)

import Browser.Dom as Dom
import Http as Http
import Json.Encode as E



--- Relations list


relatedToList =
    [ "Natasha"
    , "Bhavpreet"
    ]


defaultRelationsList =
    [ "Uncle"
    , "Aunt"
    , "Cousin"
    , "Brother"
    , "Father"
    , "Mother"
    ]


ageGroup =
    [ "Young at 💖"
    , "Above 50"
    , "30-50"
    , "20-30"
    , "< 20"
    ]


rsvpList =
    [ "Happy to attend"
    , "Unable to attend"
    ]


type alias Window =
    { width : Int
    , height : Int
    }


type alias Assets =
    { headerBgRight : String
    , footerBgLeft : String
    , footerBgRight : String
    }


type alias Flags =
    { window : Window
    , assets : Assets
    }



---- MODEL ----


type alias Model =
    { name : String
    , age : String
    , relation : Maybe String
    , nar : Bool -- Name Age Relation Flag => Indicates they are set
    , relatedTo : Maybe String
    , rsvp : Maybe String
    , awaitResp : Bool -- Flag to wait on submit status
    , tryAgain : Bool -- marker for error, have to try submit again
    , allDone : Bool -- Flag to say all values are set and submitted
    , relationsList : List String
    , showRelationText : Bool
    , infoOK1 : Bool
    , infoOK2 : Bool
    , window : Window
    , assets : Assets
    , treeInfoToggle : Bool
    , toShowEntry : Entry
    }


type alias Entry =
    { name : String
    , age : String
    , relation : String
    , relatedTo : String
    , rsvp : String
    }


type Msg
    = NoOp
    | UpdateName String
    | UpdateAge String
    | UpdateRelation String
    | UpdateRelatedTo String
    | UpdateRSVP String
    | BackToInfoPage
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
    | FocusResult (Result Dom.Error ())
    | TreeInfoToggle
    | ShowRelation E.Value
