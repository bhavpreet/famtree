module Main exposing (..)

import Browser
import Element exposing (..)
import Html exposing (Html)
import Input exposing (..)
import Model exposing (..)
import Sheets exposing (..)
import Sketch exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { name = ""
      , age = Nothing
      , relation = Nothing
      , nar = False
      , relatedTo = Nothing
      , rsvp = Nothing
      , allDone = False
      , awaitResp = False
      , tryAgain = False
      }
    , Cmd.none
    )



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateName name ->
            ( { model | name = name }
            , Cmd.none
            )

        UpdateAge age ->
            ( { model | age = String.toInt age }
            , Cmd.none
            )

        UpdateRelation relation ->
            ( { model | relation = Just relation }
            , Cmd.none
            )

        UpdateRelatedTo rTo ->
            if List.member rTo relatedToList == True then
                ( { model | relatedTo = Just rTo }
                , Cmd.none
                )

            else
                ( model, Cmd.none )

        UpdateRSVP rsvp ->
            if List.member rsvp rsvpList == True then
                ( { model | rsvp = Just rsvp }
                , Cmd.none
                )

            else
                ( model, Cmd.none )

        BackToInputRelatedTo ->
            ( { model | relatedTo = Nothing }
            , Cmd.none
            )

        BackToInputNAR ->
            ( { model | nar = False }, Cmd.none )

        NextNAR ->
            ( { model | nar = True }, Cmd.none )

        Submit ->
            ( { model | awaitResp = True }, writeToSheet model )

        SubmitRet resp ->
            -- let
            --     _ =
            --         Debug.log "Got Return : " resp
            -- in
            case resp of
                Ok _ ->
                    ( { model | allDone = True, awaitResp = False }
                    , drawBranch (encode model)
                    )

                Err _ ->
                    ( { model | tryAgain = True, awaitResp = False }
                    , Cmd.none
                    )

        AddMore ->
            ( { model
                | name = ""
                , age = Nothing
                , relation = Nothing
                , nar = False

                -- , relatedTo = Nothing
                , rsvp = Nothing
                , allDone = False
                , awaitResp = False
                , tryAgain = False
              }
            , Cmd.none
            )

        NoOp ->
            ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    layout [] <|
        column
            [ height fill
            , centerX
            , centerY
            -- , behindContent <| sketchCanvas
            ]
            [ sketchCanvas
            , viewLogic model
            ]


viewLogic : Model -> Element Msg
viewLogic model =
    if model.relatedTo == Nothing then
        inputRelatedTo model

    else if model.nar == False then
        inputNameAgeRelation model

    else if model.allDone == False then
        inputRSVP model

    else if model.awaitResp == True then
        inputAwaitResp

    else
        inputEnd model



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
