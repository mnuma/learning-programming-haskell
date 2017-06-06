-- sayHello :: String -> IO ()
-- sayHello x = putStrLn("Hello, "++ x ++ "!")
-- main = sayHello "hiro"

-- 9.3
-- ghc -e sample1 Io.hs
sample1 :: IO Char
sample1 = do
  c <- getChar
  putChar c
  return c

-- 9.4
-- ghc -e sample2 Io.hs
sample2 :: IO ()
sample2 = do
  c <- getChar
  putChar '\n'
  return c
  putChar '\n'

-- ghc -e sample3 put.hs
sample3 :: IO String
sample3 = do
  x <- getChar
  if x == '\n'
    then return []
    else do xs <- sample3
            print x
            print xs
            return (x:xs)
-- 出力結果
--x: 'c'
--xs: ""
--x: 'b'
--xs: "c"
--x: 'a'
--xs: "bc"
--"abc"

-- 9.5
-- ghc -e sample4 put.hs
-- putStrLn' :: String -> IO()
-- putStrLn' [] = return ()
-- putStrLn' (x:xs) = do
--   putChar x
--   putStr xs

-- ghc -e sample4 Io.hs
sample4 :: IO()
sample4 = do
  putStr "Enter a string: "
  xs <- getLine
  putStr "The string has: "
  putStr (show (length xs))
  putStrLn " cahacters"
