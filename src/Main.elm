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
import Sketch exposing (showRelation, sketchCanvas)
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
      , toShowEntry =
            { name = ""
            , age = ""
            , relation = ""
            , relatedTo = ""
            , rsvp = ""
            }
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
    let
        showRelation : Entry -> Element Msg
        showRelation entry =
            let
                alignment =
                    if entry.relatedTo == "Natasha" then
                        alignLeft

                    else
                        alignRight
            in
            el [ alignment ] (text entry.relation)
    in
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
            [ showRelation model.toShowEntry
            , el
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
    Sub.batch
        [ Events.onResize <|
            \width height ->
                ViewportChange { width = width, height = height }
        , showRelation ShowRelation
        ]



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.element
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
