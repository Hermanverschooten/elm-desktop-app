module Main exposing (main)

import Browser
import DesktopApp
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Encode as Json


main : Program () (DesktopApp.Model Model) Msg
main =
    DesktopApp.program
        { init = ( init, Cmd.none )
        , update = \msg model -> ( update msg model, Cmd.none )
        , subscriptions = \model -> Sub.none
        , view = view
        , files = files
        , noOp = NoOp
        }


type alias Model =
    { count : Int
    }


init : Model
init =
    { count = 0
    }


type Msg
    = NoOp
    | Loaded Int
    | Increment


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Loaded newCount ->
            { model | count = newCount }

        Increment ->
            { model | count = model.count + 1 }


view : Model -> Browser.Document Msg
view model =
    { title = ""
    , body =
        [ Html.span
            [ style "padding" "0 20px" ]
            [ Html.text (String.fromInt model.count)
            ]
        , Html.button
            [ onClick Increment ]
            [ Html.text "+" ]
        ]
    }


files : DesktopApp.File Model Msg
files =
    DesktopApp.jsonMapping Loaded
        |> DesktopApp.withInt "count" .count
        |> DesktopApp.jsonFile identity
