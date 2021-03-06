
module Bugs.Bug35 (main) where

import Text.Megaparsec
import Text.Megaparsec.Language
import Text.Megaparsec.String
import qualified Text.Megaparsec.Lexer as L

import Test.HUnit hiding (Test)
import Test.Framework
import Test.Framework.Providers.HUnit

trickyFloats :: [String]
trickyFloats =
    [ "1.5339794352098402e-118"
    , "2.108934760892056e-59"
    , "2.250634744599241e-19"
    , "5.0e-324"
    , "5.960464477539063e-8"
    , "0.25996181067141905"
    , "0.3572019862807257"
    , "0.46817723004874223"
    , "0.9640035681058178"
    , "4.23808622486133"
    , "4.540362294799751"
    , "5.212384849884261"
    , "13.958257048123212"
    , "32.96176575630599"
    , "38.47735512322269" ]

float :: Parser Double
float = L.float (L.makeLexer emptyDef)

testBatch :: Assertion
testBatch = mapM_ testFloat trickyFloats
    where testFloat x = parse float "" x @?= Right (read x :: Double)

main :: Test
main = testCase "Output of Text.Megaparsec.Lexer.float (#35)" testBatch
