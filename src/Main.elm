module Main exposing (..)

import Browser
import Browser.Events as Events
import Element exposing (..)
import Element.Background as Background
import Html exposing (Html)
import InfoPage exposing (infoPage)
import Input exposing (..)
import Model exposing (..)
import Sheets exposing (..)
import Sketch exposing (sketchCanvas)
import Update exposing (update)


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { name = ""
      , age = Nothing
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
        bottomHalf model <| inputRelatedTo model

    else if model.nar == False then
        bottomHalf model <| inputNameAgeRelation model

    else if model.allDone == False then
        bottomHalf model <| inputRSVP model

    else if model.awaitResp == True then
        bottomHalf model <| inputAwaitResp

    else
        bottomHalf model <| inputEnd model


bottomHalf : Model -> Element Msg -> Element Msg
bottomHalf model uiElem =
    column [ centerX ]
        [ el [ height (px <| model.window.height // 2) ]
            none
        , el [ padding 20 ] none
        , el
            [ height fill
            , width fill
            ]
            uiElem
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
