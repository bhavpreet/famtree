module Main exposing (..)

import Browser
import Browser.Events as Events
import Element exposing (..)
import Element.Background as Background
import Html exposing (Html)
import Html.Attributes as HAttr
import InfoPage exposing (infoPage)
import Input exposing (..)
import Model exposing (..)
import Sheets exposing (..)
import Sketch exposing (sketchCanvas)
import TreeInfo exposing (infoTreeButton, treeInfo)
import Update exposing (update)


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { name = ""
      , age = toStr (List.head ageGroup)
      , relation = Nothing
      , nar = False
      , relatedTo = Nothing
      , rsvp = Nothing
      , allDone = False
      , awaitResp = False
      , tryAgain = False
      , relationsList = defaultRelationsList
      , showRelationText = False
      , infoOK1 = False
      , infoOK2 = False
      , window = flags.window
      , assets = flags.assets
      , treeInfoToggle = False
      }
    , Cmd.batch [ fetchRelations ]
    )



---- VIEW ----


view : Model -> Html Msg
view model =
    layout
        [ width (px model.window.width)
        , height (px model.window.height)
        , behindContent <| sketchCanvas model
        ]
    <|
        viewLogic model


viewLogic : Model -> Element Msg
viewLogic model =
    if model.infoOK2 == False then
        infoPage model

    else if model.relatedTo == Nothing then
        buttonLayout model <| inputRelatedTo model

    else if model.nar == False then
        buttonLayout model <| inputNameAgeRelation model

    else if model.allDone == False then
        buttonLayout model <| inputRSVP model

    else if model.awaitResp == True then
        buttonLayout model <| inputAwaitResp

    else
        buttonLayout model <| inputEnd model


buttonLayout : Model -> Element Msg -> Element Msg
buttonLayout model uiElem =
    column
        [ height fill
        , width fill
        , inFront <| treeInfo model
        ]
        [ infoTreeButton model
        , column
            [ centerX
            , alignBottom
            , Background.color (rgb255 255 255 255)
            , alpha 0.875
            ]
            [ el
                [ height fill
                , width fill
                ]
                uiElem
            , el
                [ padding (model.window.height // 50)
                ]
                none
            ]
        ]



---- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Events.onResize <|
        \width height ->
            ViewportChange { width = width, height = height }



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
