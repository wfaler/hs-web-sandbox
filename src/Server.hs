{-# LANGUAGE OverloadedStrings #-}
import Network.Wai
import Network.HTTP.Types (status200)
import Network.Wai.Handler.Warp (run)
import Data.ByteString.Lazy as LBS

app :: Application
app req = return $ responseLBS status200 [("Content-Type", "text/plain")] (LBS.fromChunks $ [rawPathInfo req])
--	"/ok" if(requestMethod req == ) -> return $ responseLBS status200 [("Content-Type", "text/plain")] "OK"
--	"/ok/sortof" -> return $ responseLBS status200 [("Content-Type", "text/plain")] (show $ requestMethod req)

application _ = return $
  responseLBS status200 [("Content-Type", "text/plain")] "Hello World"

main = run 3000 app