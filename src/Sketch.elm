port module Sketch exposing (..)

-- import Json.Decode as D

import Element exposing (..)
import Html.Attributes as HAttr
import Json.Encode as E
import Json.Decode as D
import Model exposing (..)
import Sheets exposing (toInt, toStr)



-- sketch


port drawBranch : E.Value -> Cmd msg
port showRelation : (E.Value -> msg) -> Sub msg

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



decoder : D.Decoder Entry
decoder =
  D.map5 Entry
    (D.field "name" D.string)
    (D.field "age" D.string)
    (D.field "relation" D.string)
    (D.field "relatedTo" D.string)
    (D.field "rsvp" D.string)
