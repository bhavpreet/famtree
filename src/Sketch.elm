port module Sketch exposing (..)

-- import Json.Decode as D

import Element exposing (..)
import Html.Attributes as HAttr
import Json.Encode as E
import Model exposing (..)
import Sheets exposing (toInt, toStr)



-- sketch


port drawBranch : E.Value -> Cmd msg


sketchCanvas : Model -> Element Msg
sketchCanvas model =
    if model.infoOK2 == False then
        el
            [ htmlAttribute <| HAttr.id "sketchCanvas"
            , htmlAttribute <| HAttr.width model.window.width
            , htmlAttribute <| HAttr.height 400
            , centerX
            , transparent True
            ]
            none

    else
        el
            [ htmlAttribute <| HAttr.id "sketchCanvas"
            , htmlAttribute <| HAttr.width model.window.width
            , htmlAttribute <| HAttr.height 400
            , width fill
            , height fill
            , centerX
            ]
            none



-- JSON ENCODE/DECODE


encode : Model -> E.Value
encode model =
    E.object
        [ ( "name", E.string model.name )
        , ( "age", E.string model.age )
        , ( "relation", E.string (toStr model.relation) )
        , ( "relatedTo", E.string (toStr model.relatedTo) )
        , ( "rsvp", E.string (toStr model.rsvp) )
        , ( "isNew", E.bool True )
        ]



-- decoder : D.Decoder Model
-- decoder =
--   D.map2 Model
--     (D.field "name" D.string)
--     (D.field "email" D.string)
