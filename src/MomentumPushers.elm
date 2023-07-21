port module MomentumPushers exposing (..)

-- some explanation here?..
--

-- import Pushers

import Browser
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href)
import Html.Styled.Events exposing (onClick)
--import Playground exposing (..)
import Svg as S exposing (Svg, svg)
import Svg.Attributes as SA

-- MAIN

main : Program () Model Msg
main =
    Browser.element
        { view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        , init = init
        }
-- main =
--   Browser.sandbox { init = init, update = update, view = view }


-- PORTS


port callPusher : Float -> Cmd msg
port returnFromPusher : (Float -> msg) -> Sub msg


-- MODEL


type alias Model = Float


init : () -> (Model, Cmd msg)
init _ = (0, Cmd.none)



-- UPDATE


type Msg
  = Increment
  | Decrement
  | Reset
  | PusherArgument Float
  | PusherResult Float


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      (model + 10, Cmd.none)

    Decrement ->
      (model - 10, Cmd.none)

    Reset ->
      (0, Cmd.none)

    PusherArgument _ -> (model, Cmd.none)

    PusherResult x -> (x, Cmd.none)


-- SUBSCRIPTIONS

--- ????
subscriptions : Model -> Sub Msg
subscriptions _ =
  returnFromPusher PusherResult


-- VIEW


mystyle : Attribute Msg
mystyle = css [] -- css [ color (rgb 255 0 0), float left ] --, width (px 500) ]
mystyle2 : Attribute Msg
mystyle2 = css [ displayFlex ]

view : Model -> Html Msg
view model =
  div []
    [ div [] [ h3 [] [ text "Electron in magnetic field" ] ]
    , p [] [ text """
                    Here is how electron rotates in magnetic field with three different numerical solvers:
                    the Boris, the Vay and the Higuera--Cary pushers. They differes by...
                    """
             ]
    , div [] [ text "[Boris, Jay P. \"Relativistic plasma simulation-optimization of a hybrid code.\" Proc. Fourth Conf. Num. Sim. Plasmas. 1970.]" ]
    , div [] [ a [ href "https://doi.org/10.1063/1.2837054" ]
                 [ text "[Vay, J-L. \"Simulation of beams or plasmas crossing at relativistic velocity.\" Physics of Plasmas 15.5 (2008).]" ]
             ]
    , div [] [ a [ href "https://doi.org/10.1063/1.4979989" ]
                 [ text "[Higuera, Adam V., and John R. Cary. \"Structure-preserving second-order integration of relativistic charged particle trajectories in electromagnetic fields.\" Physics of Plasmas 24.5 (2017).]" ]
             ]
    , div [mystyle2][ div [ mystyle ] [ text ("Boris, []" ++ (String.fromFloat model))
                      , button [ onClick Decrement ] [ text "Run" ]
                      ]
             , div [ mystyle ] [ text "Vay []"
                      , button [ onClick Increment ] [ text "Run" ]
                      ]
             , div [ mystyle ] [ text "Vay []"
                      , button [ onClick Increment ] [ text "Run" ]
                      ]
             ]
    , div [] [ button [ onClick Reset ] [ text "Reset all" ] ]
    , div [] [ a [ href "Pushers.html" ] [ text "Play with pushers here" ] ]
    , fromUnstyled (Html.div [] [ S.svg [ SA.width "200", SA.height "200" ]
             [ S.circle [ SA.cx "100", SA.cy "100", SA.r "50", SA.fill "orange" ] []
             , S.circle [ SA.cx (String.fromFloat (model + 100)), SA.cy "100", SA.r "20", SA.fill "blue" ] []
             ] ])
    ]
