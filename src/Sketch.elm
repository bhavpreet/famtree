port module Sketch exposing (..)

import Element exposing (..)
import Html.Attributes as HAttr
import Json.Encode as E
-- import Json.Decode as D
import Model exposing (..)
import Sheets exposing (toStr, toInt)


-- sketch


port drawBranch : E.Value -> Cmd msg


sketchCanvas : Element Msg
sketchCanvas =
    el
        [ htmlAttribute <| HAttr.id "sketchCanvas"
        , htmlAttribute <| HAttr.width 710
        , htmlAttribute <| HAttr.height 400
        , centerX
        ]
        none


-- JSON ENCODE/DECODE


encode : Model -> E.Value
encode model =
  E.object
    [ ("name", E.string model.name)
    , ("age", E.int (toInt model.age))
    , ("relation", E.string (toStr model.relation))
    , ("relatedTo", E.string (toStr model.relatedTo))
    , ("rsvp", E.string (toStr model.rsvp))
    ]


-- decoder : D.Decoder Model
-- decoder =
--   D.map2 Model
--     (D.field "name" D.string)
--     (D.field "email" D.string)
