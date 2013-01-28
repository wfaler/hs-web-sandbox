{-# LANGUAGE OverloadedStrings #-}
import Network.Wai
import Network.HTTP.Types 
import Network.Wai.Handler.Warp (run)
import Data.ByteString.Lazy as LBS
import Data.ByteString as BS
import Data.ByteString.Char8 as CS
import Data.Text.Encoding as ENC
import Data.Maybe

app :: Application
app req = do
	respText <- return $ mapAppRequest (requestHeaders req) (queryString req)
	return $ responseLBS status200 [("Content-Type", "text/plain"), ("Set-Cookie", "haskell=foobar;Path=/")] respText
--	"/ok" if(requestMethod req == ) -> return $ responseLBS status200 [("Content-Type", "text/plain")] "OK"
--	"/ok/sortof" -> return $ responseLBS status200 [("Content-Type", "text/plain")] (show $ requestMethod req)
--	path <- rawPathInfo req
--	method <- requestMethod req
--	headers <- requestHeaders req
--	queryParams <- queryString req

mapAppRequest :: RequestHeaders -> Query -> LBS.ByteString
mapAppRequest headers queryParams = (strictsToLazyBs $ (fmap (CS.pack . show) headers) ++ (fmap mapQueryParam queryParams) ++ [(CS.pack "fåö")])

mapQueryParam :: QueryItem -> BS.ByteString
mapQueryParam (name, value) = name `BS.append` (CS.pack "=") `BS.append` (fromMaybe (CS.pack "") value)

encodeP :: BS.ByteString -> BS.ByteString
encodeP p = ENC.encodeUtf8 $ ENC.decodeUtf8 p

strictToLazyBs :: BS.ByteString -> LBS.ByteString
strictToLazyBs bs = LBS.fromChunks [bs]

strictsToLazyBs :: [BS.ByteString] -> LBS.ByteString
strictsToLazyBs bs = LBS.fromChunks bs

main = run 3000 app