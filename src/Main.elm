module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL
-- -- MODEL


type alias Key =
    { key : String
    , wasPressed : Bool
    }


type alias Keys =
    List Key


type alias Model =
    { keys : List Key }



-- createKeys : List String -> Keys
-- createKeys =
--     List.map (\x -> { key = x, wasPressed = False }) [ "a", "b", "c" ]


init : Model
init =
    Model [ { key = "a", wasPressed = False } ]



-- UPDATE


type Msg
    = KeyPressed String


updateKeyboard : List Key -> String -> List Key
updateKeyboard keys s =
    -- Find key that matches `s`
    -- if `key.wasPressed = false`, replace it with { key: `s` , wasPressed: true}
    -- if `key.wasPressed = true`, return model
    List.map
        (\x ->
            if x.key == s then
                { x | wasPressed = True }

            else
                x
        )
        keys


update : Msg -> Model -> Model
update msg model =
    case msg of
        KeyPressed x ->
            { model | keys = updateKeyboard model.keys x }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text "hey" ]
        ]
