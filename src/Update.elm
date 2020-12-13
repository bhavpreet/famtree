module Update exposing (update)

import Csv as Csv
import Model exposing (..)
import Sheets exposing (..)
import Sketch exposing (..)
import Task



---- UPDATE ----


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateName name ->
            ( { model | name = name }
            , Cmd.none
            )

        UpdateAge age ->
            ( { model | age = age }
            , Cmd.none
            )

        UpdateRelation relation ->
            case relation of
                "Other" ->
                    ( { model
                        | showRelationText = True
                        , relation = Nothing
                      }
                    , Cmd.none
                    )

                _ ->
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

        BackToInfoPage ->
            ( { model | infoOK2 = False }
            , Cmd.none
            )
        BackToInputRelatedTo ->
            ( { model
                | relatedTo = Nothing
                , showRelationText = False
              }
            , Cmd.none
            )

        BackToInputNAR ->
            ( { model | nar = False }, Cmd.none )

        NextNAR ->
            ( { model | nar = True }, Cmd.none )

        Submit ->
            if model.showRelationText == True then
                ( { model
                    | awaitResp = True
                  }
                , Cmd.batch
                    [ Task.attempt SubmitRet <| writeToSheet model
                    , Task.attempt SubmitRelationRet <|
                        writeNewRelationToSheet <|
                            toStr model.relation
                    ]
                )

            else
                ( { model | awaitResp = True }
                , Task.attempt SubmitRet <| writeToSheet model
                )

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

        SubmitRelationRet resp ->
            -- let
            --     _ =
            --         Debug.log "Relation save Got Return : " resp
            -- in
            ( { model
                | relationsList =
                    model.relationsList ++ [ toStr model.relation ]
              }
            , Cmd.none
            )

        AddMore ->
            ( { model
                | name = ""
                , age = toStr (List.head ageGroup)
                , relation = Nothing
                , nar = False

                -- , relatedTo = Nothing
                , rsvp = Nothing
                , allDone = False
                , awaitResp = False
                , tryAgain = False
                , showRelationText = False
              }
            , Cmd.none
            )

        FetchRelations resp ->
            case resp of
                Ok csvDataRaw ->
                    let
                        decodeRelations : String -> Csv.Csv
                        decodeRelations input =
                            case Csv.parse input of
                                Ok res ->
                                    res

                                Err _ ->
                                    { headers = []
                                    , records = []
                                    }

                        csvToList : Csv.Csv -> List String
                        csvToList csv =
                            List.map (\x -> toStr <| List.head x) csv.records

                        records : List String
                        records =
                            decodeRelations csvDataRaw |> csvToList

                        -- _ =
                        --     Debug.log "records = " records
                    in
                    ( { model
                        | relationsList = records
                      }
                    , Cmd.none
                    )

                Err _ ->
                    ( model, Cmd.none )

        ViewportChange window ->
            -- let
            --     _ =
            --         Debug.toString window
            -- in
            ( { model | window = window }
            , Cmd.none
            )

        InfoOK ->
            if model.infoOK1 == True then
                ( { model | infoOK1 = True }
                , Cmd.none
                )

            else
                -- ( { model | infoOK1 = True }
                ( { model | infoOK2 = True }
                , Cmd.none
                )

        NoOp ->
            ( model, Cmd.none )
