module Sheets exposing (ageToStr, fetchRelations, toInt, toStr, writeToSheet, writeNewRelationToSheet)

import Http as Http
import Model exposing (..)
import Task exposing (Task)


sheetWriteURI =
    "https://script.google.com/macros/s/AKfycbzfGamhVtRvxDPyiqf9yofRX-GdJYGd6HzSx6sITtlgmQv0aJ0/exec"

httpRespResolver : Http.Response String -> Result Http.Error String
httpRespResolver resp =
    case resp of
        Http.BadUrl_ url_ ->
            Err (Http.BadUrl url_)

        Http.Timeout_ ->
            Err Http.Timeout

        Http.NetworkError_ ->
            Err Http.NetworkError

        Http.BadStatus_ metadata body ->
            Err (Http.BadStatus metadata.statusCode)

        Http.GoodStatus_ metadata body ->
            Ok body


writeToSheet : Model -> Task Http.Error String
writeToSheet model =
    let
        url =
            sheetWriteURI
                ++ "?col1="
                ++ model.name
                ++ "&col2="
                ++ toStr model.relation
                ++ "&col3="
                ++ ageToStr model.age
                ++ "&col4="
                ++ toStr model.relatedTo
                ++ "&col5="
                ++ toStr model.rsvp

        -- _ =
        --     Debug.log "URL is " url
    in
    Http.task
        { url = url
        , method = "GET"
        , resolver = Http.stringResolver httpRespResolver
        , body = Http.emptyBody
        , headers = []
        , timeout = Nothing
        }

writeNewRelationToSheet: String -> Task Http.Error String
writeNewRelationToSheet relation =
     let
        url =
            sheetWriteURI
                ++ "?sheet=Relations"
                ++ "&col1="
                ++ relation

        -- _ =
        --     Debug.log "URL is " url
    in
    Http.task
        { url = url
        , method = "GET"
        , resolver = Http.stringResolver httpRespResolver
        , body = Http.emptyBody
        , headers = []
        , timeout = Nothing
        }

fetchRelations : Cmd Msg
fetchRelations =
    let
        url =
            "https://docs.google.com/spreadsheets/d/1ugOJeRIHwUR36fp1-MawZqqw1_X29q4nrLiKM_gu9FI/gviz/tq?tqx=out:csv&sheet=Relations"
        -- _ =
        --     Debug.log "Fetching Relations from URL: " url
    in
    Http.get
        { url = url
        , expect = Http.expectString FetchRelations
        }


ageToStr : Maybe Int -> String
ageToStr age =
    case age of
        Just age_ ->
            String.fromInt age_

        Nothing ->
            ""


toInt : Maybe Int -> Int
toInt val =
    case val of
        Just v ->
            v

        Nothing ->
            0


toStr : Maybe String -> String
toStr rel =
    case rel of
        Just rel_ ->
            rel_

        Nothing ->
            ""
