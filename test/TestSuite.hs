import Data.Monoid
import Test.Framework
import Test.Framework.Providers.HUnit
import Test.Framework.Providers.QuickCheck2
import Test.HUnit
import Test.QuickCheck
import Data.List
--import Recursivity.Stats

main :: IO ()
main = defaultMainWithOpts
       [ testCase "rev" testRev
      -- , testProperty "listRevRevId" propListRevRevId
       ] mempty

testRev :: Assertion
testRev = reverse [1, 2, 3] @?= [3, 2, 1]