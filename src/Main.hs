{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

import qualified Data.ByteString.Lazy.Char8 as L
import           Data.Maybe (fromMaybe)
import           Data.Monoid ((<>))
import           Network.HTTP.Types (status200, status405)
import           Network.HTTP.Types.Header (hContentType)
import           Network.Wai (Application, requestMethod, requestHeaders, lazyRequestBody, responseLBS)
import           Network.Wai.Handler.Warp (run)

main :: IO ()
main = do
    let port = 3000
    putStrLn $ "Listening on port " ++ show port
    run port app

app :: Application
app request finish =
    case requestMethod request of
        "POST" -> do
            let origin = fromMaybe "" (lookup "origin" (requestHeaders request))
            body <- lazyRequestBody request
            finish $ responseLBS status200 [ (hContentType, "text/plain")
                                           , ("access-control-allow-origin", origin)
                                           ] (cowsay body)

        _      -> finish $ responseLBS status405 [("allow", "POST")] ""

cowsay :: L.ByteString -> L.ByteString
cowsay text = " _" <> L.replicate len '_' <> "_"
         <> "\n< " <> text <> " >"
         <> "\n -" <> L.replicate len '-' <> "-"
         <> "\n        \\\\   ^__^"
         <> "\n         \\\\  (oo)\\\\_______"
         <> "\n            (__)\\\\       )\\\\/\\\\"
         <> "\n                ||----w |"
         <> "\n                ||     ||"
         <> "\n"
  where
    len = L.length text
